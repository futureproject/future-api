require "spec_helper"
feature "viewing Possibility Profiles" do
  scenario "as an admin" do

    visit "/"
    widget = find("#module-possibility-profiles")
    widget.click
    within(widget) do
      click_link "Ashley Wong"
    end
    within_window "Ashley Wong" do
      expect(page).to have_text "Personal Growth"
      expect(page).to have_text "You value continued personal development"
    end

  end
end
