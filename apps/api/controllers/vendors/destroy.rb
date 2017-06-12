module Api::Controllers::Vendors
  class Destroy
    include Api::Action

    params do
      required(:id).filled(:int?)
    end

    def call(params)
      vendor = VendorRepository.find(params[:id])

      if vendor
        VendorRepository.delete(vendor)
        self.status = 204
      else
        halt 404, JSON.generate(error_type: :not_found)
      end
    end
  end
end
