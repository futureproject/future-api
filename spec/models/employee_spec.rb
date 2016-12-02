require 'spec_helper'

describe Employee do
  describe 'Instance Methods' do
    describe 'portal_modules' do
      it "shows admins all modules" do
        e = Employee.find_by('admin' => '1')
        expect(e.portal_modules.count).to eq PortalModule.all_cached.count
      end
      it 'shows non-admins a subset' do
        e = Employee.some(filterByFormula: 'NOT({admin})', limit: 1).first
        expect(e.portal_modules.count).not_to eq PortalModule.all_cached.count
      end
    end
  end
end
