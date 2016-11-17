namespace :employees do
  desc "Sync to all relevant Airtable bases"
  task sync: :environment do
    puts "Syncing employees to various airtable bases"
    employees = Employee.all_cached
    bases = [
      { id: "appsSbGeUL5na71it", table_name: "People", base_name: "City Dashboard" },
      { id: "appVDoSoBOmoejlA2", table_name: "People", base_name: "Resources" },
      { id: "appmaFSuxnUkhQNy4", table_name: "People", base_name: "Dream Academy" },
      { id: "appEjF5SnQvwTuVPk", table_name: "People", base_name: "Switchboard" },
      { id: "appCkPo8BqJASORS9", table_name: "People", base_name: "Project Dashboard" },
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
        sleep 0.25
      end
    end
  end
end
