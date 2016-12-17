class City < Airmodel::Model
  has_many :people, base_key: 'student_data_base_id'

  def self.default_sort
    ["Name", :asc]
  end

  def self.all_cached
    App.cache.fetch("cities", 31536000) { all }
  end

  def self.find_in_cache_by_tfpid(tfpid)
    all_cached.find{|c| c['TFPID'] == tfpid }
  end

end
