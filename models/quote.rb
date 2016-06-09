class Quote < Sequel::Model
  plugin :validation_helpers

  def self.default
    self.new(body: "Education is what is left after one has forgotten everything one learned in school.", source: "Einstein")
  end

  def self.daily
    q = self.offset(rand(self.all.count.to_i)).first
    q || self.default
  end

  def validate
    super
    validates_presence [:body, :source]
  end
end
