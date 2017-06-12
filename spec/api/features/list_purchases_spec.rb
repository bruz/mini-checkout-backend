require 'features_helper'

describe 'GET /purchases' do
  before do
    PurchaseRepository.clear
    purchase = Purchase.new(payment_method: payment_method, time: Time.now)
    purchase.line_items << LineItem.new(vendor_id: vendor_id, price: price)

    PurchaseRepository.create_with_line_items(purchase)
  end

  let(:payment_method) { 'credit' }
  let(:vendor_id) { 42 }
  let(:price) { 12.0 }

  it 'list all purchases' do
    get '/purchases'

    last_response.status.must_equal 200
    parsed = JSON.parse(last_response.body, symbolize_names: true)
    purchase = parsed.first
    purchase[:payment_method].must_equal payment_method
    purchase[:time].wont_be_nil
    purchase[:line_items].size.must_equal 1

    line_item = purchase[:line_items].first
    line_item[:vendor_id].must_equal vendor_id
    line_item[:price].must_equal 12.0
  end
end
