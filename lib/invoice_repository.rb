require 'csv'
require_relative 'invoice'
require_relative 'repository_actions'
require_relative 'repository_find_generator'

class InvoiceRepository

  include RepositoryActions
  extend  RepositoryFindGenerator

  attr_reader :type, :engine

  def initialize(engine, filename = default_filename)
    @type          = Invoice
    @engine        = engine
    load(filename)
  end

  def default_filename
    "./data/invoices.csv"
  end

  def invoices_grouped_by_merchant_id
    @invoices_grouped_by_merchant_id = all.group_by { |invoice| invoice.merchant_id }
  end

  def find_by_merchant_id(merchant_id)
    Array(invoices_grouped_by_merchant_id[merchant_id]).first
  end

  def find_all_by_merchant_id(merchant_id)
    invoices_grouped_by_merchant_id[merchant_id] || []
  end

  def create(invoice_data)
    invoice_data[:id] = all.last.id + 1
    invoice = Invoice.new(parse_invoice_data(invoice_data), self)
    create_invoice_items_for_invoice(invoice_data)
    all << invoice
    nuke_groups
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

  #define_find_methods_for(Invoice)
  define_new_find_methods_for(Invoice)
  define_new_find_all_methods_for(Invoice)
  define_id_methods_for(Invoice)

end
