class AdminController < ApplicationController

  before do
    authenticate!
  end

  get "/" do
    erb :"admin/index"
  end

  get "/flush" do
    App.cache.flush
    flash[:notice] = "Cache cleared!"
    redirect "/admin"
  end

  get "/sync_employees" do
    Thread.new do
      puts "syncing employees.."
      `rake employees:sync`
      puts "... done"
    end
    flash[:notice] = "Syncing employees, will finish in 2ish minutes."
    redirect "/admin"
  end

end


