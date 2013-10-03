require_relative 'unit_conversions'

class Item

  include UnitConversions

  attr_reader :id, :name, :description, :unit_price, :merchant_id,
              :created_at, :updated_at, :repo

  def initialize(data = {}, repo = nil)
    @id          = data[:id].to_i
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = convert_to_big_decimal(data[:unit_price])
    @merchant_id = data[:merchant_id].to_i
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @repo = repo
  end

  def self.public_attributes
    [ :id, :name, :description, :unit_price, :merchant_id, :created_at,
      :updated_at ]
  end

  def invoice_items
    repo.engine.invoice_item_repository.find_all_by_item_id(id)
  end

  def merchant
    repo.engine.merchant_repository.find_by_id(merchant_id)
  end

  def successful_invoice_items
    invoice_items.find_all(&:successful?)
  end

  def best_day
    Date.parse(best_invoice_by_invoice_item.created_at)
  end

  def best_invoice_item
    successful_invoice_items.sort_by(&:quantity).reverse[0]
  end

  def best_invoice_by_invoice_item
    repo.engine.invoice_repository.find_by_id(best_invoice_item.invoice_id)
  end

  def quantity_sold
    successful_invoice_items.inject(0) do |sum, invoice_item|
      sum += invoice_item.quantity
    end
  end

  def revenue
    successful_invoice_items.inject(0) do |sum, invoice_item|
      sum += invoice_item.total
    end
  end

end
