require 'roar/decorator'
require 'roar/json'

module Api::Representers
  class Purchase < Roar::Decorator
    include Roar::JSON

    property :id
    property :payment_method
    property :time
    collection :line_items, class: LineItem do
      property :vendor_id
      property :price
    end
  end
end
