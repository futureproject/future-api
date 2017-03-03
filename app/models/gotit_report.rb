class GotitReport

  def initialize(city, time=Time.now)
    @city = city
    puts @city
    @week = Time.at(time).beginning_of_week
  end

  def schools
    School.all_cached.select{|s| s.tfpid.include? @city}
  end

  def stats
    @statistics ||= schools.map do |school|
      {
        "School" => school.tfpid,
        "Stats" => SchoolStatSheet.new(school: school, week: @week).stats
      }
    end
  end

end
