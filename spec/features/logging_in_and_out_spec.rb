require "spec_helper"

feature "Logging" do
  scenario "in" do
    visit "/"
    expect(page).to have_content "links"
  end
  scenario "out" do
    visit "/"
    click_link "Log Out"
    expect(page).to have_content "logged out"
  end
end
