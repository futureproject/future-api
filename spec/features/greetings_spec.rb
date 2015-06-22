require "spec_helper"
feature "being greeted" do
  scenario "on the home page" do
    visit "/"
    should_see_greeting
  end

  def should_see_greeting
    page.should have_content "Hello."
  end

end
