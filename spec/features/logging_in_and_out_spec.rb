require "spec_helper"

feature "Logging" do
  scenario "in" do
    visit "/"
    expect(page).to have_content "Log Out"
  end
  scenario "out" do
    visit "/"
    click_link "Log Out"
    expect(page).to have_content "logged out"
  end
  scenario "in as an unauthorized user" do
    disable_automatic_auth
    visit "/"
    expect(page).to have_content "Auth error"
  end
end
