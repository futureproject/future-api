namespace :caches do
  desc "Warm all the extremely expensive caches"
  task warm: :environment do
    puts "warming the cache"
    App.cache.flush
    #store recent commitments
    Commitment.recent
    #store upcoming commitments
    Commitment.upcoming
    Employee.all_cached.each do |employee|
      # store gotit commitments for this employee
      employee.student_commitments
      # store this employee in memcache so Auth goes quickly
      App.cache.set(employee.cache_key, employee)
      # store this employee's tasks
      Task.undone_for_user(employee.goddamn_tfpid)
    end
  end
end

