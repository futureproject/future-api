Sequel.migration do
  up do
    drop_table :framesets
    create_table :quotes do
      primary_key :id
      text :body
      text :source
      timestamp :created_at
      timestamp :updated_at
    end
  end
  down do
    drop_table :quotes
  end
end
