require "spec_helper"
feature "Redirects" do
  before do
    FactoryGirl.create_list :redirect, 10
  end
  scenario "listing" do
    visit "/"
    should_see_redirects
  end
  def should_see_redirects
    expect(page).to have_content "You look nice today, links"
  end
end
