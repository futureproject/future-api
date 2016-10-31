require "spec_helper"

describe TypeformClient do
  describe "Class Methods" do
    describe "possibility_profile" do
      it "imports possibility profiles from Typeform" do
        s = SAMPLE_TYPEFORM_RESPONSE
        t = TypeformClient.parse_for_airtable(s)
      end
    end
  end
end
