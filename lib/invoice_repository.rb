require 'csv'
require_relative 'invoice'
require_relative 'repository_actions'

class InvoiceRepository

  include RepositoryActions

  attr_reader :type, :engine

  RepositoryActions::define_find_methods_for(Invoice)

  def initialize(engine, filename = default_filename)
    @type          = Invoice
    @engine        = engine
    load(filename)
  end

  def default_filename
    "./data/invoices.csv"
  end

  def create(invoice_data)
    invoice_data[:id] = all.count + 1
    invoice = Invoice.new(parse_invoice_data(invoice_data), self)
    create_invoice_items_for_invoice(invoice_data)
    all << invoice
    invoice
  end

  def create_invoice_items_for_invoice(invoice_data)
    engine.invoice_item_repository.create_invoice_items(invoice_data)
  end

  def parse_invoice_data(invoice_data)
    {
      :id          => invoice_data[:id],
      :customer_id => invoice_data[:customer].id,
      :merchant_id => invoice_data[:merchant].id,
      :status      => invoice_data[:status],
      :created_at  => time_now,
      :updated_at  => time_now
    }
  end

end
