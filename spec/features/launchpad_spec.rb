require "spec_helper"
feature "Launchpad" do

  scenario "as a logged-in user" do
    visit "/"
    should_see_tools
    should_see_upcoming_commitments
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

  def should_see_upcoming_commitments
    expect(page).to have_content "Commitments"
  end

end
