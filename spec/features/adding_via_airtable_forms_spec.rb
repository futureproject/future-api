require "spec_helper"
feature "adding records via airtable forms" do

  scenario "e.g. commitments" do
    visit "/"
    within "#airtable-forms" do
      click_link "Commitment"
      should_see_form_for "Commitment"
    end
  end

  scenario "e.g. engagements" do
    visit "/"
    within "#airtable-forms" do
      click_link "Engagement"
      should_see_form_for "Engagement"
    end
  end

  scenario "e.g. projects" do
    visit "/"
    within "#airtable-forms" do
      click_link "Project"
      should_see_form_for "Project"
    end
  end


  def should_see_form_for(record_type)
    frame = find('iframe')
    within_frame(frame) do
      expect(page).to have_content "New #{record_type}"
    end
  end

end

