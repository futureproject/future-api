class Redirect < Sequel::Model
  plugin :validation_helpers
  def validate
    super
    validates_presence [:shortcut, :url]
    validates_unique :shortcut
    validates_format /\Ahttps?:\/\//, :url, message:'is not a valid URL'
  end
end
