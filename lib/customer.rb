class Customer

  attr_reader :id, :first_name, :last_name, :created_at, :updated_at, :repo

  def initialize(data = {}, repo = nil)
    @id         = data[:id].to_i
    @first_name = data[:first_name]
    @last_name  = data[:last_name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repo = repo
  end

  def public_attributes
    [ :id, :first_name, :last_name, :created_at, :updated_at  ]
  end

  def invoices
    repo.engine.invoice_repository.find_all_by_customer_id(id)
  end

  def successful_invoices
    invoices.find_all { |invoice| invoice.successful? }
  end

  def favorite_merchant
    repo.engine.merchant_repository.find_by_id(favorite_merchant_id)
  end

  def favorite_merchant_id
    merchant_count.max_by { |merchant_id, count| count }[0]
  end

  def merchant_count
    successful_invoices.each_with_object(Hash.new(0)) do |invoice, count|
      count[invoice.merchant_id] += 1
    end
  end

  def transactions
    invoices.collect { |invoice|
      repo.engine.transaction_repository.find_all_by_invoice_id(invoice.id)
    }.flatten
  end
end
