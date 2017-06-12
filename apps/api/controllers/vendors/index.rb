module Api::Controllers::Vendors
  class Index
    include Api::Action

    expose :vendors

    def call(_)
      vendors = VendorRepository.all
      hashes = vendors.map do |vendor|
        Api::Representers::Vendor.new(vendor).to_hash
      end

      self.status = 200
      self.body = hashes.to_json
    end
  end
end
