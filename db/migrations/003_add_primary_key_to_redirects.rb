Sequel.migration do
  up do
    alter_table :redirects do
      drop_column :id
      add_primary_key :id
    end
  end
  down do
    #
  end
end
