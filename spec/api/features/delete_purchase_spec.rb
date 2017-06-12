require 'features_helper'

describe 'DELETE /purchases/:id' do
  before do
    PurchaseRepository.clear
  end

  let(:purchase) {
    purchase = Purchase.new(payment_method: 'check', time: Time.now)
    purchase.line_items << LineItem.new(vendor_id: 1, price: 15.0)

    PurchaseRepository.create_with_line_items(purchase)
  }

  it 'deletes an existing purchase' do
    delete "/purchases/#{purchase.id}"

    last_response.status.must_equal 204
    PurchaseRepository.all.to_a.size.must_equal 0
  end

  it 'shows a not found error when the purchase does not exist' do
    delete '/purchases/0'

    last_response.status.must_equal 404
    parsed = JSON.parse(last_response.body, symbolize_names: true)
    parsed[:error_type].must_equal 'not_found'
  end
end
