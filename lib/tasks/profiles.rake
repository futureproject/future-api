namespace :profiles do
  task sync: :environment do
    TypeformClient.import_all
  end

  task map_headers: :environment do
    surveys = TypeformClient.possibility_profiles
    headers = surveys["questions"].map{|q| TypeformClient.strip_html(q["question"]) }.uniq
    file = CSV.open("#{Dir.pwd}/schema.csv", "wb") do |csv|
      csv << headers
    end
  end

end