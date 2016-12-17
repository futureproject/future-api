require 'spec_helper'
feature 'loading data from the api' do

  scenario 'to view all cities' do
    visit_with_token '/api/v1/cities'
    expect(page).to have_content 'NYC'
  end

  scenario 'to view a particular city do' do
    visit_with_token '/api/v1/cities/NYC'
    expect(page).to have_content 'NYC'
  end

  def visit_with_token(url)
    token = Employee.first.goddamn_tfpid
    visit "#{url}?token=#{token}"
  end
end
