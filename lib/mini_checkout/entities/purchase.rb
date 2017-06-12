class Purchase
  include Hanami::Entity

  attributes :time, :payment_method, :line_items

  def initialize(attributes = {})
    super
    @line_items ||= []
  end
end
