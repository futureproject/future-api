DB = YAML.load_file("#{App.root}/settings/airtable.yml")[App.environment]

module Airtabled
  @@client = Airtable::Client.new(ENV["AIRTABLE_API_KEY"])

  # return an Airtable::Table object, backed by a base defined in DB
  def airtable(table_name)
    data_locator = DB[table_name.downcase.to_sym] || raise(NoSuchBase)
    @@client.table(data_locator[:base_id], data_locator[:table_name])
  end

  def find(id)
    table.find id
  end

  def find_by(attrs)
    all.select{|e| e[attrs.keys[0]] == attrs.values[0] }.first
  end

  class NoSuchBase < StandardError
  end
end

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

  end
end
