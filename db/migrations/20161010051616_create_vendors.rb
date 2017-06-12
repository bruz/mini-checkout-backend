Hanami::Model.migration do
  change do
    create_table :vendors do
      primary_key :id
      column :name,   String, null: false
      column :number, String, null: false
    end
  end
end
