module Api::Controllers::Purchases
  class Index
    include Api::Action

    expose :purchases

    def call(_)
      purchases = PurchaseRepository.all_with_line_items
      hashes = purchases.map do |purchase|
        Api::Representers::Purchase.new(purchase).to_hash
      end

      self.status = 200
      self.body = hashes.to_json
    end
  end
end
