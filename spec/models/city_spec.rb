require 'spec_helper'

describe City do
  describe 'self.all_cached' do
    it 'looks in the cache for all cities, then looks in airtable' do
      VCR.use_cassette 'cities' do
        cities = City.all_cached
        expect(cities.count).to be > 4
        expect(cities.first.respond_to?(:tfpid)).to be true
      end
    end
  end
  describe 'self.find_in_cache_by_tfpid' do
    it 'queries city.all_cached for a particular city' do
      VCR.use_cassette 'cities' do
        nyc = City.find_in_cache_by_tfpid('NYC')
        expect(nyc.tfpid).to eq 'NYC'
      end
    end
  end

  describe 'self.people' do
    it 'returns an array of students from gotit' do
      VCR.use_cassette 'city.people' do
        nyc = City.find_in_cache_by_tfpid('NYC')
        people = nyc.people.some
        expect(people.first.role).to eq "Student"
        people = nyc.people.some
      end
    end
  end
end
