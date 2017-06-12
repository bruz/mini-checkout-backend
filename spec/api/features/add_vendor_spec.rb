require 'features_helper'

describe 'POST /vendors' do
  before do
    VendorRepository.clear
  end

  let(:vendor_name) { 'VENDOR' }
  let(:vendor_number) { '23' }

  it 'adds a new vendor' do
    post '/vendors', name: vendor_name, number: vendor_number

    last_response.status.must_equal 201
    parsed = JSON.parse(last_response.body, symbolize_names: true)
    parsed[:name].must_equal vendor_name
    parsed[:number].must_equal vendor_number

    vendor = VendorRepository.first
    vendor.name.must_equal vendor_name
    vendor.number.must_equal vendor_number
  end

  it 'fails with missing params' do
    post '/vendors', name: vendor_name

    last_response.status.must_equal 422
    parsed = JSON.parse(last_response.body, symbolize_names: true)
    parsed[:error_type].must_equal 'invalid_params'
    parsed[:params].must_equal number: ['is missing']
  end
end
