Hanami::Model.migration do
  change do
    create_table :purchases do
      primary_key :id
      column :payment_method, String, null: false
    end

    create_table :line_items do
      primary_key :id
      column :purchase_id, Integer, null: false
      column :vendor_id, Integer, null: false
      column :price, BigDecimal, null: false
    end
  end
end
