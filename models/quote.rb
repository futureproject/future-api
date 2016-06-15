class Quote
  extend Airtabled
  @@table = airtable("Quotes")

  # fetches a random quote from Airtable API, caches it for 24 hours
  def self.fetch_and_cache_quotes
    quotes = @@table.records
    App.cache.set("quotes", quotes, 86400) if quotes.length > 0
    quotes
  end

  #returns a hard-coded default quote
  def self.default
    Airtable::Record.new(
      body: "Education is what is left after one has forgotten everything one learned in school.",
      source: "Albert Einstein"
    )
  end

  # rate-limited API call to airtable for 100 most recent records
  def self.all
    @@table.records
  end

  # cached alias of above
  def self.all_cached
    App.cache.get("quotes") || fetch_and_cache_quotes
  end

  # cycles through the quotes in cache, returning one each day
  def self.daily(manual_offset = 0)
    quotes = all_cached
    count = quotes.size
    if count > 0
      index = (Date.today.yday + manual_offset) % count
      quotes[index]
    else
      self.default
    end
  end


end
