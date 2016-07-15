require "spec_helper"

feature "As a Dream Director I can" do
  scenario "view upcoming incomplete tasks from the Epic Dashboard" do
    visit "/"
    expect(page).to have_content "Tasks from the Epic Dashboard"
  end
  scenario "view an iframe of the Library Activities"
  scenario "add a new activity Library Activites via a form"
  scenario "favorite Library Activites via a form"
  scenario "view a the Library Vault in an iframe"
  scenario "view Templates from the vault in an iframe"
  scenario "browse products in the Store via an iframe"
  scenario "view a list of employees and browse their favorite activites"
  scenario "follow links to Namely, Slack, and Expensify"
  scenario "view commitments from Gotit"
  scenario "search for student profiles"
  scenario "add a commitment from a student profiles"
  scenario "view a graph of Student Commitments Made vs Student Commitments Completed"
  scenario "respond to reflection prompts"
end
