module Airtabled
  @@client = Airtable::Client.new(ENV["AIRTABLE_API_KEY"])

  def airtable(table_name)
    @@client.table(ENV["AIRTABLE_BASE_ID"], table_name)
  end

end
