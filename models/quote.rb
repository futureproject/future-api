class Quote
  extend Airtabled
  @@table = airtable("Quotes")

  # fetches a random quote from Airtable, caches it
  def self.get_and_cache_quotes
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
  def all
    @@table.records
  end

  # cached alias of above
  def all_cached
    App.cache.get("quotes") || fetch_and_cache_quotes
  end

  # quote of the day!
  def self.daily
    App.cache.get("DAILY_QUOTE") || self.fetch_and_cache_quote
  end

end
