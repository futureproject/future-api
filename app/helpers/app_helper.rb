module AppHelper

  def airtable_formatted(hash)
    Airmodel::Model.airtable_formatted(hash)
  end

  def asset_path(filename)
    # parse webpack-generated asset fingerprint
    @@asset_fingerprint ||= File.read("#{App.root}/public/assets/fingerprint.txt")
    f = filename.split(".")
    prefix = f.first
    extension = f.last
    if settings.production?
      "/assets/#{prefix}-#{@@asset_fingerprint}.#{extension}"
    else
      if !App.assets_compiled
        App.set :assets_compiled, true
        system "npm run build-dev"
      end
      "/assets/#{filename}"
    end
  end

end
