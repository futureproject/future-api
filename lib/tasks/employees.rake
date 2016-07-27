namespace :employees do
  desc "Sync to all relevant Airtable bases"
  task sync: :environment do
    puts "Syncing employees to various airtable bases"
    employees = Employee.all
    bases = [
      { id: "appsSbGeUL5na71it", table_name: "People" }
    ]
    bases.each do |base|
      table = Airtable::Client.new(ENV["AIRTABLE_API_KEY"]).table(
        base[:id], base[:table_name]
      )
      #iterate over each employee
      employees.each do |employee|
        #find or create record by TFPID
        record = table.records(filterByFormula:"TFPID = '#{employee.tfpid}'").first ||
          table.create(Airtable::Record.new({"TFPID": employee.tfpid}))
        attrs = {
          "NAME": employee.name,
          "TITLE": employee.title,
          "SCHOOL_TFPID": employee.school_tfpid,
          "CITY_TFPID": employee.city_tfpid
        }
        table.update_record_fields(record.id, attrs)
      end
    end
  end
end
