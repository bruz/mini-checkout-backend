require 'features_helper'

describe 'PATCH /vendors/:id' do
  before do
    VendorRepository.clear
  end

  let(:vendor) {
    VendorRepository.create(
      Vendor.new(name: "OLD_NAME", number: "OLD_NUMBER")
    )
  }
  let(:new_name) { 'NEW_NAME' }
  let(:new_number) { 'NEW_NUMBER' }

  it 'updates an existing vendor' do
    patch "/vendors/#{vendor.id}", name: new_name, number: new_number, active: false

    last_response.status.must_equal 200
    parsed = JSON.parse(last_response.body)
    parsed['name'].must_equal new_name
    parsed['number'].must_equal new_number
    parsed['active'].must_equal false

    vendor = VendorRepository.first
    vendor.name.must_equal new_name
    vendor.number.must_equal new_number
  end

  it 'shows a not found error when the vendor does not exist' do
    patch '/vendors/0', name: new_name, number: new_number

    last_response.status.must_equal 404
    parsed = JSON.parse(last_response.body, symbolize_names: true)
    parsed[:error_type].must_equal 'not_found'
  end
end
