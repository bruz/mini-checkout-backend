require 'hanami/model'
require 'hanami/mailer'
Dir["#{ __dir__ }/mini_checkout/**/*.rb"].each { |file| require_relative file }

Hanami::Model.configure do
  adapter type: :sql, uri: ENV['DATABASE_URL']

  migrations 'db/migrations'
  schema     'db/schema.sql'

  mapping do
    collection :vendors do
      entity     Vendor
      repository VendorRepository

      attribute :id,     Integer
      attribute :name,   String
      attribute :number, String
      attribute :active, Boolean
    end

    collection :purchases do
      entity     Purchase
      repository PurchaseRepository

      attribute :id,             Integer
      attribute :time,           Time
      attribute :payment_method, String
    end

    collection :line_items do
      entity     LineItem
      repository LineItemRepository

      attribute :id,          Integer
      attribute :purchase_id, Integer
      attribute :vendor_id,   Integer
      attribute :price,       BigDecimal
    end
  end
end.load!

Hanami::Mailer.configure do
  root "#{ __dir__ }/mini_checkout/mailers"

  delivery do
    development :test
    test        :test
    # TODO: production
  end
end.load!
