module AppHelper

  def airtable_formatted(hash)
    Airmodel::Model.airtable_formatted(hash)
  end

  def asset_path(filename)
    f = filename.split(".")
    prefix = f.first
    extension = f.last
    if settings.production?
      "/assets/#{prefix}-#{ASSET_FINGERPRINT}.#{extension}"
    else
      "/assets/#{filename}"
    end
  end


end
