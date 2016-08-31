require "spec_helper"
feature "Registration" do
  scenario do
    disable_automatic_auth
    visit "/"
  end
end

