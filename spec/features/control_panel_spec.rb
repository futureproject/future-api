require "spec_helper"
feature "visiting the admin panel" do
  scenario "as an admin" do
    visit "/"
    click_link "Admin"
    expect(page).to have_content "Admin Tools"
  end
end

