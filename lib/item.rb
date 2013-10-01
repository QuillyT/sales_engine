require 'bigdecimal'

class Item

  attr_reader :id, :name, :description, :unit_price, :merchant_id,
              :created_at, :updated_at, :repo

  def initialize(data = {}, repo = nil)
    @id          = data[:id].to_i
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = convert_unit_price(data[:unit_price])
    @merchant_id = data[:merchant_id].to_i
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @repo = repo
  end

  def convert_unit_price(cents)
    BigDecimal.new(convert_cents_to_dollars(cents))
  end

  def convert_cents_to_dollars(cents)
    cents.to_s.rjust(3, "0").insert(-3, ".")
  end

  def public_attributes
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
    invoice_items.find_all { |invoice_item| invoice_item.successful? }
  end

  def best_day
    Date.parse (successful_invoice_items.sort_by { |invoice_item| 
      invoice_item.quantity
    }.reverse[0].created_at)
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
