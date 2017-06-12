Hanami::Model.migration do
  change do
    alter_table :purchases do
      add_column :time, Time, null: false
    end
  end
end
