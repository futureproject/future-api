module Airtabled
  @@client = Airtable::Client.new(ENV["AIRTABLE_API_KEY"])
  @@tables = YAML.load_file("#{App.root}/settings/airtable.yml")[App.environment]

  def airtable(table_name)
    locator = @@tables[table_name.downcase.to_sym]
    @@client.table(locator[:base_id], locator[:table_name])
  end

end
