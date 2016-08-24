DB = YAML.load_file("#{App.root}/settings/airtable.yml")[App.environment]

module Airtabled
  @@client = Airtable::Client.new(ENV["AIRTABLE_API_KEY"])

  # return an Airtable::Table object, backed by a base defined in DB yaml file
  def table(table_name=self.name.tableize.to_sym)
    data_locator = DB[table_name.downcase.to_sym] || raise(NoSuchBase)
    @@client.table(data_locator[:base_id], data_locator[:table_name])
  end

  # returns all records in the database, making as many calls as necessary
  # to work around Airtable's 100-record per page design
  def all(args={sort: default_sort})
    puts "RUNNING EXPENSIVE API QUERY TO AIRTABLE (#{self.name})"
    table.all(args)
  end

  # returns up to 100 records from Airtable
  def records(args={sort: default_sort})
    puts "RUNNING EXPENSIVE API QUERY TO AIRTABLE (#{self.name})"
    table.records(args)
  end

  # default to whatever order airtable returns
  # this method gets overridden on Airtabled classes
  def default_sort
    nil
  end

  def find(id)
    table.find id
  end

  def find_by(attrs)
    all.select{|e| e[attrs.keys[0]] == attrs.values[0] }.first
  end

  # convert blank strings to nil, and [""] to []
  def airtable_formatted_hash(hash)
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

  # update this record in airtable, but only the values
  # supplied in the hash. (PUT, insanely, overwrites all
  # values that aren't in the hash with nil.)
  def patch(attrs)
    id = attrs.delete(:id) || attrs.delete("id")
    if self.table.update_record_fields(id, attrs)
      attrs
    else
      false
    end
  end


  # raise this error when a table
  # is not defined in settings/airtable.yml
  class NoSuchBase < StandardError
  end

end

# Airtable monkeypatches!
module Airtable
  class Table < Resource
    def update(record)
      result = self.class.put(worksheet_url + "/" + record.id,
        :body => { "fields" => record.fields_for_update }.to_json,
        :headers => { "Content-type" => "application/json" }).parsed_response
      if result.present? && result["id"].present?
        record.override_attributes!(result_attributes(result))
        record
      else # failed
       puts result
       false
      end
    end

    def update_record_fields(record_id, fields_for_update)
      result = self.class.patch(worksheet_url + "/" + record_id,
        :body => { "fields" => fields_for_update }.to_json,
        :headers => { "Content-type" => "application/json" }).parsed_response
      if result.present? && result["id"].present?
        Record.new(result_attributes(result))
      else # failed
        puts result
        false
      end
    end

  end

end
