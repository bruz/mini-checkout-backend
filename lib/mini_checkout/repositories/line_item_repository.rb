class LineItemRepository
  include Hanami::Repository

  def self.by_purchase(purchase)
    query do
      where(purchase_id: purchase.id)
    end
  end
end
