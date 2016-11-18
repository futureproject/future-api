module StatHandler
  def self.commitments_by_city(dataset)
    cities = City.all_cached.reject{|x| x.name.match(/hq/i) }
    index = 0
    stats = []
    cities.each do |city|
      records = dataset.select{|x| x.school_tfpid.match(city.tfpid) }
      count_completed = records.select{|x| x.is_complete? }.count
      count_overdue = records.count - count_completed
      color = Dreamo::COLORS[index % Dreamo::COLORS.count]
      index += 1
      stats.push({
        title: city.name,
        text: "#{records.count} total\n #{count_completed} complete\n#{count_overdue} to do",
        color: color,
        fallback: city
      })
    end
    stats
  end
end
