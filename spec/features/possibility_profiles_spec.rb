require "spec_helper"
feature "viewing Possibility Profiles" do
  scenario "as an admin" do

    visit "/"
    widget = find("#module-possibility-profiles")
    VCR.use_cassette 'possibility_profiles' do
      widget.click
      within(widget) do
        click_link "Dinette Boomer"
      end
    end
    VCR.use_cassette 'dinette_boomer' do
      within_window "Dinette Boomer" do
        expect(page).to have_text "Personal Growth"
        expect(page).to have_text "You value continued personal development"
      end
    end

  end
end
