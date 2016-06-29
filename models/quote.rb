class Quote
  extend Airtabled

  #returns a hard-coded default quote
  def self.default
    Airtable::Record.new(
      body: "Education is what is left after one has forgotten everything one learned in school.",
      source: "Albert Einstein"
    )
  end

  def self.all
    table.all(view: "Main View")
  end

  # inexpensive cache-backed version of all
  def self.all_cached
    App.cache.fetch("quotes", 86400) { all }
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
