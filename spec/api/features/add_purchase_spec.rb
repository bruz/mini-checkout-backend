require 'features_helper'

describe 'POST /purchases' do
  before do
    PurchaseRepository.clear
  end

  let(:payment_method) { 'credit' }
  let(:vendor_id) { 42 }

  it 'adds a new purchase' do
    post '/purchases', payment_method: payment_method, line_items: [
      { vendor_id: vendor_id, price: 12.00 }
    ]

    last_response.status.must_equal 201
    parsed = JSON.parse(last_response.body, symbolize_names: true)
    parsed[:payment_method].must_equal payment_method

    purchase = PurchaseRepository.first
    purchase.payment_method.must_equal payment_method
  end

  it 'fails with missing params' do
    post '/purchases', payment_method: payment_method

    last_response.status.must_equal 422
    parsed = JSON.parse(last_response.body, symbolize_names: true)
    parsed[:error_type].must_equal 'invalid_params'
    parsed[:params].must_equal line_items: ['is missing']
  end
end
