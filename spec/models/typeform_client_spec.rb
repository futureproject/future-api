require "spec_helper"

describe TypeformClient do
  describe "Class Methods" do
    describe "possibility_profile" do
      it "imports possibility profiles from Typeform" do
        s = SAMPLE_TYPEFORM_RESPONSE
        attrs = TypeformClient.parse_for_airtable(s)
        record = PossibilityProfile.new(attrs)
        expect(record.valid?).to eq true
      end
    end

    describe "missing_profiles" do
      it "returns a list of PossibilityProfiles that haven't been imported yet" do
        t = TypeformClient.missing_profiles
        expect(t.length).to be > 100
      end
    end
  end
end
