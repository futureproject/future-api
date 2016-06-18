module AppHelper
  def airtable_url_for(base_name)
    "https://airtable.com/#{DB[base_name.downcase.to_sym][:base_id]}"
  end
end
