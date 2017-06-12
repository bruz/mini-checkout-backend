require 'roar/decorator'
require 'roar/json'

module Api::Representers
  class Vendor < Roar::Decorator
    include Roar::JSON

    property :id
    property :name
    property :number
    property :active
  end
end
