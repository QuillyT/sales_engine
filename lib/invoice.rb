class Invoice

  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, 
              :updated_at, :repo

  def initialize(data = {}, repo = nil)
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repo = repo
  end

  def public_attributes
    [ :id, :customer_id, :merchant_id, :status, :created_at, :updated_at ]
  end

  def transactions
    repo.engine.transaction_repository.find_all_by_invoice_id(id)
  end

  def invoice_items
    repo.engine.invoice_item_repository.find_all_by_invoice_id(id)
  end

  def customer
    repo.engine.customer_repository.find_by_id(customer_id)
  end

  def merchant
    repo.engine.merchant_repository.find_by_id(merchant_id)
  end

  def items
    invoice_items.collect do |invoice_item|
      repo.engine.item_repository.find_by_id(invoice_item.item_id)
    end
  end
end
