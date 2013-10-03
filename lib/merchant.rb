require 'bigdecimal'

class Merchant

  attr_reader :id, :name, :created_at, :updated_at, :repo

  def initialize(data={}, repo = nil)
    @id         = data[:id].to_i
    @name       = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repo       = repo
  end

  def self.public_attributes
    [ :id, :name, :created_at, :updated_at ]
  end

  def items
    repo.engine.item_repository.find_all_by_merchant_id(id)
  end

  def quantity
    successful_invoices.map(&:quantity).inject(0, &:+)
  end

  def invoices
    repo.engine.invoice_repository.find_all_by_merchant_id(id)
  end

  def successful_invoices
    invoices.find_all { |invoice| invoice.successful? }
  end

  def pending_invoices
    invoices.find_all { |invoice| invoice.pending? }
  end

  def favorite_customer
    repo.engine.customer_repository.find_by_id(favorite_customer_id)
  end

  def customer_counts
    successful_invoices.each_with_object(Hash.new(0)) do |invoice, counts|
      counts[invoice.customer_id] += 1
    end
  end

  def favorite_customer_id
    customer_counts.max_by { |customer_id, count| count }[0]
  end

  def invoices_by_date(date)
    successful_invoices.find_all do |invoice|
      Date.parse(invoice.created_at) == date
    end
  end

  def revenue(date = nil)
    if date.nil?
      successful_invoices_revenue
    else
      date_invoices_revenue(date)
    end
  end

  def successful_invoices_revenue
    successful_invoices.inject(0) { |sum, invoice| sum += invoice.total }
  end

  def date_invoices_revenue(date)
    invoices_by_date(date).inject(0) { |sum, invoice| sum += invoice.total }
  end

  def customers_with_pending_invoices
    pending_invoices.collect do |invoice|
      repo.engine.customer_repository.find_by_id(invoice.customer_id)
    end
  end

end
