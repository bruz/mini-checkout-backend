class PurchaseRepository
  include Hanami::Repository

  def self.all_with_line_items
    sorted = query { reverse_order(:time) }
    sorted.map do |purchase|
      purchase.line_items = LineItemRepository.by_purchase(purchase).to_a
      purchase
    end
  end

  def self.create_with_line_items(purchase)
    created_purchase = create(purchase)

    purchase.line_items.each do |line_item|
      line_item.purchase_id = created_purchase.id
      created_purchase.line_items << LineItemRepository.create(line_item)
    end

    created_purchase
  end

  def self.delete_with_line_items(purchase)
    delete(purchase)
    LineItemRepository.by_purchase(purchase).each do |line_item|
      LineItemRepository.delete(line_item)
    end
  end

  def self.update_with_line_items(purchase)
    update(purchase)

    LineItemRepository.by_purchase(purchase).each do |old_line_item|
      LineItemRepository.delete(old_line_item)
    end

    purchase.line_items.each do |line_item|
      line_item.purchase_id = purchase.id
      LineItemRepository.create(line_item)
    end
  end
end
