require 'spec_helper'

describe NamelyClient do

  describe 'employees' do
    it 'returns a list of employees from the namely api' do
      puts 'listing employees...'
      VCR.use_cassette 'namely_employees' do
        list = NamelyClient.employees
        expect(list.first.to_h[:email]).to match '@thefutureproject.org'
      end
    end
  end

  describe 'find_employee' do
    it 'finds an employee by id' do
      id = VCR.use_cassette 'namely_employees' do
        NamelyClient.employees.first[:id]
      end
      VCR.use_cassette "namely_employee_#{id}" do
        hayley = NamelyClient.find_employee id
        expect(hayley[:first_name]).to eq "Hayley"
      end
    end
  end

end
