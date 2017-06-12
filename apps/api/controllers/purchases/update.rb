module Api::Controllers::Purchases
  class Update
    include Api::Action

    params do
      required(:id).filled(:int?)
      required(:payment_method).filled(:str?)
      required(:line_items).each do
        schema do
          required(:vendor_id).filled(:int?)
          required(:price).filled(:float?)
        end
      end
    end

    def call(params)
      purchase = PurchaseRepository.find(params[:id])

      if purchase
        line_items = params[:line_items].map do |attributes|
          LineItem.new(attributes)
        end
        purchase.update(
          payment_method: params[:payment_method],
          line_items: line_items
        )

        PurchaseRepository.update_with_line_items(purchase)
        render_success(purchase)
      else
        render_failure
      end
    end

    private

    def render_success(purchase)
      self.status = 200
      self.body = Api::Representers::Purchase.new(purchase).to_json
    end

    def render_failure
      halt 404, JSON.generate(error_type: :not_found)
    end
  end
end
