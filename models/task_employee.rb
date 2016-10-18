class TaskEmployee < Airmodel::Model

  def self.search(args)
    filters = []
    filters.push ["FIND('#{args[:name].downcase}', LOWER(NAME)) > 0"] if args[:name]
    some(
      sort: ["NAME", :asc],
      filterByFormula: "AND(#{filters.join(',')})"
    )
  end

end
