module Api::Controllers::Vendors
  class Create
    include Api::Action

    params do
      required(:name).filled(:str?)
      required(:number).filled(:str?)
    end

    def call(params)
      vendor = VendorRepository.create(
        Vendor.new(
          name: params[:name],
          number: params[:number],
          active: true
        )
      )

      self.status = 201
      self.body = Api::Representers::Vendor.new(vendor).to_json
    end
  end
end
