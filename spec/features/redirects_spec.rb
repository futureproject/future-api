require "spec_helper"
feature "Redirects" do

  before do
    FactoryGirl.create_list :redirect, 10
  end

  scenario "listing" do
    visit "/redirects"
    should_see_redirects
  end

  scenario "creating" do
    visit "/"
    click_link "Redirects"
    click_link "Add Link"
    fill_in "redirect[shortcut]", with: "echobase"
    fill_in "redirect[url]", with: "http://www.starwars.com/"
    click_button "Make it so."
    expect(page).to have_content "/echobase"
  end

  scenario "updating" do
    visit "/redirects"
    click_link "Edit", match: :first
    fill_in "redirect[shortcut]", with: "topsecret"
    click_button "Make it so."
    expect(page).to have_content "/topsecret"
  end

  def should_see_redirects
    expect(page).to have_content "You look nice today, links"
  end

end
