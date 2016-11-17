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

  #task import: :environment do
    #TypeformClient.import_all
  #end

  task score: :environment do
    PossibilityProfile.all.each do |profile|
      profile.score
    end
  end

  task import: :environment do
    profiles = TypeformClient.missing_profiles
    errors = []
    profiles.each do |profile|
      puts "importing #{profile['token']}..."
      begin
        TypeformClient.import_one profile["token"]
      rescue
        errors.push profile["token"]
      end
      puts "... done."
    end
    puts "Failed to import these profiles"
    puts errors
  end

end
