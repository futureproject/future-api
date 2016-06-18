class Commitment
  extend Airtabled
  @@table = airtable(:commitments)

  def self.undone_for_user(email)
    puts "RUNNING EXPENSIVE QUERY"
    airtable_formula = "AND(FIND('#{email}', {user_id}) > 0, {Status} = 'Ongoing')"
    @@table.records(sort: ["Due", :asc], filterByFormula: airtable_formula)
  end

  def self.undone_for_user_cached(email)
    App.cache.fetch("commitments_undone_for_user_#{email}", 30) {
      undone_for_user(email)
    }
  end

end


