require "spec_helper"
feature "viewing Possibility Profiles" do
  scenario "as an admin" do

    visit "/"
    widget = find("#module-possibility-profiles")
    widget.click
    link_text = ""
    within(widget) do
      click_link "Benjamin Sisko"
    end
    within_window "Benjamin Sisko" do
      expect(page).to have_text "Purpose"
    end

    # clean up
    PossibilityProfile.find_by("Name": "Benjamin Sisko").update(
      "Power Strength": nil,
      "Possibility Strength": nil,
      "Passion & Purpose Strength": nil,
    )
  end
end
