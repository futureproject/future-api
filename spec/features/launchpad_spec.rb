require "spec_helper"
feature "Launchpad" do

  scenario "as a signed-in user" do
    visit "/"
    should_see_tools
  end


  def should_see_tools
    expect(page).to have_selector "#launchpad"
    expect(page).to have_content "Logbook"
  end

end
