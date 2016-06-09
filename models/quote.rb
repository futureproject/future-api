class Quote < Sequel::Model
  plugin :validation_helpers

  #returns a hard-coded default quote
  def self.default
    self.new(
      body: "Education is what is left after one has forgotten everything one learned in school.",
      source: "Albert Einstein"
    )
  end

  #cycles through the quotes in the DB, returning one each day
  def self.daily(manual_offset = 0)
    count = self.count
    if count > 0
      self.offset((Date.today.yday + manual_offset) % count)
    else
      self.default
    end
  end

  def validate
    super
    validates_presence [:body, :source]
  end

end
