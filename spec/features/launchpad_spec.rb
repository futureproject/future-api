require "spec_helper"
feature "Launchpad" do

  scenario "as a logged-in user" do
    visit "/"
    should_see_tools
  end

  scenario "not as a logged-out user" do
    disable_automatic_auth
    visit "/"
    expect(page).to have_content "Auth error"
  end

  def should_see_tools
    expect(page).to have_selector "#launchpad"
    expect(page).to have_content "Logbook"
  end

end
