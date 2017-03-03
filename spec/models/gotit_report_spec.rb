require "spec_helper"

describe GotitReport do
  it "takes a city_tfpid and returns a group for each school" do
    report = GotitReport.new("NYC")
    expect(report.schools.first.tfpid).to include "NYC-"
  end

  it "returns an array of stats" do
    report = GotitReport.new("NYC")
    puts report.stats
  end
end
