require "spec_helper"
feature "Registration" do

  scenario "With no Slack account" do
    enable_automatic_auth "asfasvweqr@thefutureproject.org"
    visit "/"
    should_see_slack_registration_prompt
  end

  scenario "With a Slack account and no profile info in Airtable" do
    enable_automatic_auth("kanya.balakrishna@thefutureproject.org")
    visit "/"
    complete_registration_form
    should_be_registered_as_kanya
  end


  def should_see_slack_registration_prompt
    expect(page).to have_content "Please create a Slack account"
  end

  def complete_registration_form
    select "NYC - Richard R Green High School of Teaching", from: "employee[School][]"
    select "New York, NY", from: "employee[City][]"
    click_button "Let's do this."
  end

  def should_be_registered_as_kanya
    within find("body > footer") do
      expect(page).to have_content "Kanya Balakrishna"
    end
    # Delete kanya's registration in the Test Base so that
    # we can do this all again later
    Employee.find_by("Email": "kanya.balakrishna@thefutureproject.org").destroy
  end
end

