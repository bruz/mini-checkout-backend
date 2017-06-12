module Api::Controllers::Vendors
  class Update
    include Api::Action

    params do
      required(:id).filled(:int?)
      required(:name).filled(:str?)
      required(:number).filled(:str?)
      optional(:active).filled(:bool?)
    end

    def call(params)
      vendor = VendorRepository.find(params[:id])

      if vendor
        vendor.update(
          name: params[:name],
          number: params[:number],
          active: params[:active]
        )
        VendorRepository.update(vendor)
        render_success(vendor)
      else
        render_failure
      end
    end

    private

    def render_success(vendor)
      self.status = 200
      self.body = Api::Representers::Vendor.new(vendor).to_json
    end

    def render_failure
      halt 404, JSON.generate(error_type: :not_found)
    end
  end
end
