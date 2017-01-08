require "spec_helper"

feature "I can manage student commitments" do

  scenario "by toggling" do
    visit "/"
    original_task = find_first_task_on_page("#module-got-it")
    complete_first_task_on_page("#module-got-it")

    # reload the page
    visit "/"
    new_task = find_first_task_on_page("#module-got-it")
    # expect that the first task is now different
    expect(original_task).not_to eq new_task

    #clean up
    Commitment.find_by(id: original_task).update("Complete?": false)
  end

  def find_first_task_on_page(element_id="#module-city-dashboard")
    widget = find(element_id)
    widget.click
    widget.find("form.toggle", match: :first)[:action].split("/").last
  end

  def complete_first_task_on_page(element_id="#module-city-dashboard")
    widget = find(element_id)
    checkbox = find("input[type=checkbox]", match: :first)
    checkbox.click
    expect(widget).not_to have_css('input[disabled]')
  end

end

