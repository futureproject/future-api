Sequel.migration do
  up do
    if !table_exists?(:redirects)
      create_table :redirects do
        primary_key :id
        text :shortcut
        text :url
        timestamp :created_at
        timestamp :updated_at
      end
    end
    if table_exists?(:go_redirects)
      drop_table :go_redirects
    end
  end
  down do
    drop_table :redirects
  end
end
