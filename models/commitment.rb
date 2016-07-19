class Commitment
  extend Airtabled

  def self.all_cached
    App.cache.fetch("commitments", 3600) { records(view: "Main View") }
  end

  def self.undone_for_user(user)
    airtable_formula = "AND(FIND('#{user.email}', {user_id}) > 0, {Status} = 'Ongoing')"
    self.records(sort: ["Due", :asc], filterByFormula: airtable_formula)
  end

  def self.undone_for_user_cached(user)
    App.cache.fetch("commitments_undone_for_user_#{user.email}", 60) {
      undone_for_user(user)
    }
  end

end


