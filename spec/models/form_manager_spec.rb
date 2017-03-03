require "spec_helper"

describe FormManager do
  let(:user_with_no_city) { Employee.new }
  let(:user_with_city) { Employee.new("city_tfpid" => "NYC") }
  describe "forms_for" do
    it "returns some forms when the user has a city" do
      expect(FormManager.forms_for(user_with_no_city)).to be nil
      expect(FormManager.forms_for(user_with_city)).not_to be nil
    end
  end
end

