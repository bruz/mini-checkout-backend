module Api::Controllers::Purchases
  class Destroy
    include Api::Action

    params do
      required(:id).filled(:int?)
    end

    def call(params)
      purchase = PurchaseRepository.find(params[:id])

      if purchase
        PurchaseRepository.delete_with_line_items(purchase)
        self.status = 204
      else
        halt 404, JSON.generate(error_type: :not_found)
      end
    end
  end
end
