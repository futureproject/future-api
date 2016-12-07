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

  task :port_tfpids => :environment do
    puts "pulling employees from airtable"
    airtable_employees = Employee.all
    puts "pulling employees from namely"
    namely_employees = NamelyClient.employees
    airtable_employees.each do |x|
      namely_employee = namely_employees.find{|y| y.email == x.email }
      if namely_employee
        begin
          puts "updating #{namely_employee[:first_name]}"
          namely_employee.update tfpid: x.goddamn_tfpid
        rescue Namely::FailedRequestError
          puts "failed to update #{namely_employee[:first_name]}"
        end
      end
    end
  end

  task :sync_projects => :environment do
    puts "pulling employees from airtable"
    airtable_employees = TaskEmployee.all
    puts "pulling employees from namely"
    namely_employees = NamelyClient.employees
    airtable_employees.each do |x|
      namely_employee = namely_employees.find{|y| y.tfpid == x.tfpid }
      if namely_employee
        begin
          puts "updating projects for #{namely_employee[:first_name]} #{namely_employee[:last_name]}"
          namely_employee.update(
            projects_i_m_sponsoring: x.projects_sponsoring.join("\n"),
            projects_i_m_leading: x.projects_leading.join("\n"),
            projects_i_m_on: x.projects_supporting.join("\n")
          )
        rescue Namely::FailedRequestError
          puts "failed to update #{namely_employee[:first_name]}"
        end
      end
    end
  end

end
