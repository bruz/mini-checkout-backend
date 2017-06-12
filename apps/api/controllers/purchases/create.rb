module Api::Controllers::Purchases
  class Create
    include Api::Action

    params do
      required(:payment_method).filled(:str?)
      required(:line_items).each do
        schema do
          required(:vendor_id).filled(:int?)
          required(:price).filled(:float?)
        end
      end
    end

    def call(params)
      purchase = Purchase.new(
        payment_method: params[:payment_method],
        time: Time.now
      )

      params[:line_items].each do |attributes|
        line_item = LineItem.new(attributes)
        purchase.line_items << line_item
      end

      created_purchase = PurchaseRepository.create_with_line_items(purchase)

      self.status = 201
      self.body = Api::Representers::Purchase.new(created_purchase).to_json
    end
  end
end
