require "spec_helper"
feature "Redirects" do

  scenario " to thefutureproject.org by default" do
    visit "/#{SecureRandom.uuid}"
    expect(current_url).to eq App.settings.default_redirect
  end

  scenario "to a defined redirect" do
    visit "/directory"
    expect(current_url).to include "google.com"
  end
end
