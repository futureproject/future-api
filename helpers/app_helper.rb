module AppHelper

  def airtable_url_for(base_name)
    "https://airtable.com/#{DB[base_name.downcase.to_sym][:base_id]}"
  end

  def airtable_formatted(hash)
    Airtable::Model.airtable_formatted(hash)
  end

end
