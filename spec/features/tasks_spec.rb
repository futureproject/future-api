require "spec_helper"

feature "I can toggle tasks" do
  scenario "sourced from the Team Dashboard" do
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

  scenario "or adding them from outside airtable" do
    visit "/"
    find("#module-city-dashboard").click
    complete_task_form
    expect(page).to have_content "Commitment added!"

    visit "/"
    find("#module-city-dashboard").click
    within "#module-city-dashboard" do
      expect(page).to have_content "pass this test"
    end

    #clean up
    Task.find_by("Commitment": "pass this test").destroy
  end

  def find_first_task_on_page(element_id="#module-city-dashboard")
    widget = find(element_id)
    widget.click
    widget.find("form", match: :first).text
  end

  def complete_first_task_on_page(element_id="#module-city-dashboard")
    widget = find(element_id)
    checkbox = find("input[type=checkbox]", match: :first)
    checkbox.click
    expect(widget).not_to have_css('input[disabled]')
  end

  def complete_task_form
    click_button "Add New"
    within '#new-task' do
      who = first('.selectize-input input[type=text]')
      q = "Chris"
      who.set(q)
      option = find('div[data-selectable]', text: q, match: :first)
      option.click
      fill_in("record[Commitment]", with: "pass this test")
      click_button "Add to Dashboard"
    end
  end
end
