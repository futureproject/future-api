require "spec_helper"

feature "As a Dream Director I can" do

  scenario "toggle incomplete tasks from the City Dashboard" do
    visit "/"
    old_task_text = find_first_task_on_page
    complete_first_task_on_page

    # reload the page
    visit "/"
    new_task_text = find_first_task_on_page
    # expect that the first task is now different
    expect(old_task_text).not_to eq new_task_text

    #clean up
    Task.find_by("Commitment": old_task_text).update("Complete?": false)
  end

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

  scenario "view possibility profiles" do
    visit "/"
    widget = find("#module-possibility-profiles")
    widget.click
    link_text = ""
    within(widget) do
      click_link "Benjamin Sisko"
    end
    within_window "Benjamin Sisko" do
      expect(page).to have_text "Autonomy"
    end
  end
  scenario "view commitments from Gotit"

  #scenario "search for student profiles"

  #scenario "add a commitment from a student profiles"

  #scenario "view a graph of Student Commitments Made vs Student Commitments Completed"

  scenario "respond to reflection prompts"

  def find_first_task_on_page
    widget = find("#module-city-dashboard")
    widget.click
    widget.find("form", match: :first).text
  end

  def complete_first_task_on_page
    widget = find("#module-city-dashboard")
    checkbox = find("input[type=checkbox]", match: :first)
    checkbox.click
    #wait until the AJAX request goes through
    expect(widget).not_to have_css('input[disabled]')
  end

end
