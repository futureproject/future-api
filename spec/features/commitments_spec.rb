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

  scenario "by adding" do
    visit "/"
    find("#module-got-it").click
    complete_commitment_form
    expect(page).to have_content "Commitment added!"
    #clean up
    Commitment.find_by("Commitment": "pass this test").destroy
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

  def complete_commitment_form
    click_button "Add New"
    within '#new-commitment' do
      who = first('.selectize-input input[type=text]')
      q = "Elwin"
      who.set(q)
      option = find('div[data-selectable]', text: q, match: :first)
      option.click
      fill_in("record[Commitment]", with: "pass this test")
      click_button "Got it."
    end
  end
end

