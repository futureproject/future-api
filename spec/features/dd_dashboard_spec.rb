require "spec_helper"

feature "As a Dream Director I can" do

  scenario "follow links to Namely, Slack, and Expensify" do
    visit "/"
    widget = find("#module-external-tools")
    widget.click
    within(widget) do
      expect(page).to have_content "Namely"
      expect(page).to have_content "Slack"
      expect(page).to have_content "Expensify"
    end
  end


  #scenario "search for student profiles"

  #scenario "add a commitment from a student profiles"

  #scenario "view a graph of Student Commitments Made vs Student Commitments Completed"

  scenario "respond to reflection prompts"
end
