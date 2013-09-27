class Merchant

  attr_reader :id, :name, :created_at, :updated_at, :repo

  def initialize(data={}, repo = nil)
    @id         = data[:id].to_i
    @name       = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repo       = repo
  end

  def public_attributes
    [ :id, :name, :created_at, :updated_at ]
  end

  def items
    repo.engine.item_repository.find_all_by_merchant_id(id)
  end

  def invoices
    repo.engine.invoice_repository.find_all_by_merchant_id(id)
  end

  def successful_invoices
    invoices.find_all do |invoice|
      transaction = invoice.transactions.find do |transaction| 
        transaction.result == "success"
      end
      ! transaction.nil?
    end
  end

  def revenue
    sum = successful_invoices.inject(0) do |sum, invoice|
      items = repo.engine.invoice_item_repository.find_all_by_invoice_id(invoice.id)
      sum += items.inject(0) do |item_sum, item|
        item_sum += (item.unit_price * item.quantity)
      end
    end
    sum
  end

end
