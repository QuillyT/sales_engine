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

  def quantity
    successful_invoices.inject(0) { |sum, invoice| sum += invoice.quantity }
  end

  def invoices
    repo.engine.invoice_repository.find_all_by_merchant_id(id)
  end

  def successful_invoices
    invoices.find_all { |invoice| invoice.successful? }
  end

  def revenue
    successful_invoices.inject(0) { |sum, invoice| sum += invoice.total }
  end

end
