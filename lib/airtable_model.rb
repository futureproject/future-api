DB ||= YAML.load_file("#{App.root}/config/airtable_data.yml")[App.environment]

module Airtable
  class Model < Record
    @@client = Airtable::Client.new(ENV["AIRTABLE_API_KEY"])

    # return an Airtable::Table object, backed by a base defined in DB yaml file
    def self.table(table_name=self.name)
      data_locator = DB[table_name.tableize.to_sym] || raise(NoSuchBase)
      @@client.table(data_locator[:base_id], data_locator[:table_name])
    end

    def self.at(base_id, table_name)
      @@client.table(base_id, table_name)
    end

    ## converts array of generic airtable records to the instances
    # of the appropriate class
    def self.classify(records=[])
      records.map{|r| self.new(r.fields) }
    end

    # returns all records in the database, making as many calls as necessary
    # to work around Airtable's 100-record per page design
    def self.all(args={sort: default_sort})
      puts "RUNNING EXPENSIVE API QUERY TO AIRTABLE (#{self.name})"
      self.classify table.all(args)
    end

    # returns up to 100 records from Airtable
    def self.records(args={sort: default_sort})
      puts "RUNNING EXPENSIVE API QUERY TO AIRTABLE (#{self.name})"
      self.classify table.records(args)
    end

    # default to whatever order airtable returns
    # this method gets overridden on Airtabled classes
    def self.default_sort
      nil
    end

    # find records that match the filters
    def self.where(filters)
      formula = "AND(" + filters.map{|k,v| "{#{k}}='#{v}'" }.join(',') + ")"
      records(
        filterByFormula: formula,
      )
    end

    # find a record by ID, return it
    def self.find(id)
      record = table.find(id)
      self.new(record.fields)
    end

    # find a record by specified attributes, return it
    def self.find_by(attrs)
      formula = "AND(" + attrs.map{|k,v| "{#{k}}='#{v}'" }.join(',') + ")"
      results = records(
        filterByFormula: formula,
        limit: 1
      )
      results.length == 1 ? results.first : nil
    end

    # return the first record
    def self.first
      results = records(
        limit: 1
      )
      results.length == 1 ? results.first : nil
    end

    # create a new record and save it to Airtable
    def self.create(*records)
      results = records.map{|r| record = self.new(r); table.create(record); }
      results.length == 1 ? results.first : results
    end

    # send a PATCH request to update a few fields on a record in one API call
    def self.patch(id, fields)
      r = self.table.update_record_fields(id, airtable_formatted(fields))
      self.new(r.fields)
    end

    # convert blank strings to nil, [""] to [], and "true" to a boolean
    def self.airtable_formatted(hash)
      h = hash.dup
      h.each{|k,v|
        if v == [""]
          h[k] = []
        elsif v == ""
          h[k] = nil
        elsif v == "true"
          h[k] = true
        elsif v == "false"
          h[k] = false
        end
      }
    end

    #
    # Infuriatingly, some of our records are split across multiple artable bases
    # this function returns some or all, using the configuration at config/airtable_data.yml
    def self.sharded_records(args)
      db_label = args.delete(:table_name)
      db_tables = DB[db_label.tableize.to_sym]
      city_base = db_tables[args.delete(:city_name)]
      if city_base
        self.at(city_base, db_label).records(args)
      else
        results = []
        db_tables.each do |key, val|
          results <<  self.at(val, db_label).records(args)
        end
        results.flatten
      end

    end




    # INSTANCE METHODS

    def save
      if new_record?
        self.class.table.create(self)
      else
        self.class.table.update_record_fields(id, self.changed_fields)
      end
    end

    def changed_fields
      current = fields
      old = self.class.find(id).fields
      current.diff(old)
    end

    def destroy
      self.class.table.destroy(id)
    end

    def update(fields)
      self.class.table.update_record_fields(id, fields)
    end

    def new_record?
      id.nil?
    end

    def cache_key
      "#{self.class.name.tableize}_#{self.id}"
    end

    # iterate through all the many ways TFPID might be
    # fucking defined on this thing, return the first one that works
    def goddamn_tfpid
      keys = [self["TFPID"], self[:tfpid], self[:TFPID], self["tfpid"]]
      keys.find{|u| !u.nil? }
    end

    # iterate through all the many ways CITY_ID might be
    # fucking defined on this thing, return the first one that works
    def goddamn_city
      keys = [self["CITY_TFPID"], self[:city_tfpid], self[:CITY_TFPID], self["city_tfpid"]]
      keys.find{|u| !u.nil? }
    end

    # iterate through all the many ways SCHOOL_ID might be
    # fucking defined on this thing, return the first one that works
    def goddamn_school
      keys = [self["SCHOOL_TFPID"], self[:school_tfpid], self[:SCHOOL_TFPID], self["school_tfpid"]]
      keys.find{|u| !u.nil? }
    end
  end

  # raise this error when a table
  # is not defined in config/airtable_data.yml
  class NoSuchBase < StandardError
  end

end
