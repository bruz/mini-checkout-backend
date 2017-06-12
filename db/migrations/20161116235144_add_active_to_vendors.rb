Hanami::Model.migration do
  change do
    alter_table :vendors do
      add_column :active, TrueClass, null: false, default: true
    end
  end
end
