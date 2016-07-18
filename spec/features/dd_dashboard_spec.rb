require "spec_helper"

feature "As a Dream Director I can" do
  scenario "view upcoming incomplete tasks from the Epic Dashboard"

  scenario "view an iframe of the Library Activities" do
    visit "/"
    expect(page).to have_content "Browse The Library"
  end

  #scenario "add a new activity Library Activites via a form"

  #scenario "favorite Library Activites via a form"

  #scenario "view a the Library Vault in an iframe"

  #scenario "view Templates from the vault in an iframe"

  scenario "browse products in the Store via an iframe" do
    visit "/"
    expect(page).to have_content "Order Swag"
  end

  scenario "view a list of employees and browse their favorite activites"

  scenario "follow links to Namely, Slack, and Expensify" do
    visit "/"
    expect(page).to have_content "Do something elsewhere"
    expect(page).to have_content "Namely"
    expect(page).to have_content "Slack"
    expect(page).to have_content "Expensify"
  end

  scenario "view commitments from Gotit"

  #scenario "search for student profiles"

  #scenario "add a commitment from a student profiles"

  #scenario "view a graph of Student Commitments Made vs Student Commitments Completed"

  scenario "respond to reflection prompts"
end
