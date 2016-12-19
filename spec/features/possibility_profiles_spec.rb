require "spec_helper"
feature "viewing Possibility Profiles" do
  scenario "as an admin" do

    visit "/"
    widget = find("#module-possibility-profiles")
    VCR.use_cassette 'possibility_profiles' do
      widget.click
      profile = window_opened_by { click_link "Dinette Boomer" }
      within_window(profile) do
        expect(page).to have_text "Personal Growth"
      end
    end

  end
end
