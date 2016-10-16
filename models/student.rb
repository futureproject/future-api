class Student < Airmodel::Model

  def self.search(args)
    filters = []
    filters.push ["FIND('#{args[:name].downcase}', LOWER(Name)) > 0"] if args[:name]
    filters.push("{SCHOOL_TFPID} = '#{args[:school]}'") if args[:school]
    records(
      shard: args[:shard],
      sort: ["Name", :asc],
      filterByFormula: "AND(#{filters.join(',')})"
    )
  end

  def goddamn_city
    goddamn_school.try(:split, "-").try(:first)
  end

  def shard_identifier
    goddamn_city
  end

end
