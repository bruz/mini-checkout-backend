require 'features_helper'

describe 'DELETE /vendors/:id' do
  before do
    VendorRepository.clear
  end

  let(:vendor) {
    VendorRepository.create(
      Vendor.new(name: "NAME", number: "NUMBER")
    )
  }

  it 'deletes an existing vendor' do
    delete "/vendors/#{vendor.id}"

    last_response.status.must_equal 204
    VendorRepository.all.to_a.size.must_equal 0
  end

  it 'shows a not found error when the vendor does not exist' do
    delete '/vendors/0'

    last_response.status.must_equal 404
    parsed = JSON.parse(last_response.body, symbolize_names: true)
    parsed[:error_type].must_equal 'not_found'
  end
end
