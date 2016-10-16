module AppHelper

  def airtable_formatted(hash)
    Airmodel::Model.airtable_formatted(hash)
  end

end
