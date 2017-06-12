class LineItem
  include Hanami::Entity

  attr_accessor :price

  attributes :purchase_id, :vendor_id

  def initialize(attributes = {})
    super
    @price = attributes[:price]
  end

  def price
    # price is a BigDecimal, which serializes to a String by default. Converting
    # to a float isn't completely safe, but should be OK for this app
    @price.to_f
  end
end
