class Person < Airmodel::Model

  #override table methods, because they're dependent
  #on the location we're querying
  #
  # self.table uses a Class Instance Variable that should be set
  # from the parent scope. See City.people for an example
  def self.table
    Airmodel.client.table @base_id, "People"
  end

  def table
    self.class.table
  end

  def self.search(args)
    filters = []
    filters.push ["FIND('#{args[:name].downcase}', LOWER(Name)) > 0"] if args[:name]
    filters.push("{SCHOOL_TFPID} = '#{args[:school]}'") if args[:school]
    some(
      sort: ["Name", :asc],
      filterByFormula: "AND(#{filters.join(',')})"
    )
  end

  def goddamn_city_tfpid
    goddamn_school.try(:split, "-").try(:first)
  end

  def city
    City.find_in_cache_by_tfpid(self.goddamn_city_tfpid)
  end

end

