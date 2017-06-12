require 'features_helper'

describe 'PATCH /purchases/:id' do
  before do
    PurchaseRepository.clear
  end

  let(:purchase) {
    purchase = Purchase.new(payment_method: 'check', time: Time.now)
    purchase.line_items << LineItem.new(vendor_id: 1, price: 15.0)

    PurchaseRepository.create_with_line_items(purchase)
  }
  let(:payment_method) { 'credit' }
  let(:vendor_id) { 42 }
  let(:price) { 12.0 }

  it 'updates an existing purchase' do
    patch "/purchases/#{purchase.id}", {
      payment_method: payment_method,
      line_items: [
        { vendor_id: vendor_id, price: price }
      ]
    }

    last_response.status.must_equal 200
    purchase = JSON.parse(last_response.body, symbolize_names: true)
    purchase[:payment_method].must_equal payment_method
    purchase[:line_items].size.must_equal 1

    line_item = purchase[:line_items].first
    line_item[:vendor_id].must_equal vendor_id
    line_item[:price].must_equal price
  end

  it 'shows a not found error when the purchase does not exist' do
    patch "/purchases/0", {
      payment_method: payment_method,
      line_items: [
        { vendor_id: vendor_id, price: price }
      ]
    }

    last_response.status.must_equal 404
    parsed = JSON.parse(last_response.body, symbolize_names: true)
    parsed[:error_type].must_equal 'not_found'
  end
end
