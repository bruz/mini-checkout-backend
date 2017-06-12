require 'features_helper'

describe 'GET /vendors' do
  before do
    VendorRepository.clear
    vendor
  end

  let(:vendor) {
    VendorRepository.create(
      Vendor.new(name: "NAME", number: "NUMBER")
    )
  }

  it 'lists all vendors' do
    get '/vendors'

    last_response.status.must_equal 200
    parsed = JSON.parse(last_response.body, symbolize_names: true)
    parsed.first[:name].must_equal vendor.name
    parsed.first[:number].must_equal vendor.number
  end
end
