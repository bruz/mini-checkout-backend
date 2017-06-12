require 'spec_helper'

describe PurchaseRepository do

  let(:payment_method) { 'check' }
  let(:vendor_id) { 42 }
  let(:price) { 12.0 }
  let(:new_payment_method) { 'credit' }
  let(:new_price) { 15.0 }

  def create_purchase
    purchase = Purchase.new(payment_method: payment_method, time: Time.now)
    purchase.line_items << LineItem.new(vendor_id: vendor_id, price: price)

    created_purchase = PurchaseRepository.create_with_line_items(purchase)
    created_purchase.id
  end

  def update_purchase(id)
    purchase = PurchaseRepository.find(id)
    purchase.line_items << LineItem.new(vendor_id: vendor_id, price: new_price)
    purchase.update(payment_method: new_payment_method)

    PurchaseRepository.update_with_line_items(purchase)
  end

  before(:each) do
    PurchaseRepository.clear
    LineItemRepository.clear
  end

  describe ".all_with_line_items" do
    it "returns all purchases with their line items" do
      id = create_purchase

      purchases = PurchaseRepository.all_with_line_items
      purchases.size.must_equal 1
      purchase = purchases.first
      purchase.payment_method.must_equal payment_method
      purchase.line_items.size.must_equal 1

      line_item = purchase.line_items.first
      line_item.vendor_id.must_equal vendor_id
      line_item.price.must_equal price
      line_item.purchase_id.must_equal id
    end
  end

  describe ".create_with_line_items" do
    it "creates a purchase with line items" do
      id = create_purchase

      purchase = PurchaseRepository.find(id)
      purchase.payment_method.must_equal payment_method

      line_item = LineItemRepository.by_purchase(purchase).first
      line_item.purchase_id.must_equal purchase.id
      line_item.vendor_id.must_equal vendor_id
      line_item.price.must_equal price
    end
  end

  describe ".delete_with_line_items" do
    it "deletes a purchase and its line items" do
      id = create_purchase

      purchase = PurchaseRepository.find(id)
      PurchaseRepository.delete_with_line_items(purchase)

      PurchaseRepository.find(id).must_equal nil
      LineItemRepository.by_purchase(purchase).count.must_equal 0
    end
  end

  describe ".update_with_line_items" do
    it "updates a purchase with line items" do
      id = create_purchase
      update_purchase(id)

      purchase = PurchaseRepository.find(id)
      purchase.payment_method.must_equal new_payment_method

      line_item = LineItemRepository.by_purchase(purchase).first
      line_item.purchase_id.must_equal purchase.id
      line_item.vendor_id.must_equal vendor_id
      line_item.price.must_equal new_price
    end
  end
end
