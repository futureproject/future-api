require "spec_helper"

feature "I can toggle things from the dashboard" do

  scenario "like tasks" do
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

  scenario "like Student Commitments" do
    visit "/"
    old_task_text = find_first_task_on_page("#module-got-it")
    complete_first_task_on_page("#module-got-it")

    # reload the page
    visit "/"
    new_task_text = find_first_task_on_page("#module-got-it")
    # expect that the first task is now different
    expect(old_task_text).not_to eq new_task_text

    #clean up
    Commitment.find_by("Commitment": old_task_text).update("Complete?": false)
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
end

