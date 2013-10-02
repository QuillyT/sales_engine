require 'csv'
require_relative 'invoice'

class InvoiceRepository

  attr_reader :type, :engine

  def initialize(filename=nil, engine = nil)
    @type          = Invoice
    @engine        = engine
    load(filename)
  end

  def default_filename
    "./data/invoices.csv"
  end

  def load(filename)
    filename ||= default_filename
    @instance_hashes = CSV.read filename, headers: true, header_converters: :symbol
  end

  def all
    @instances ||= create_instances
  end

  def create_instances
    @instance_hashes.collect { |data| type.new(data, self) }
  end

  def random
    all.sample
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
      :created_at  => Time.now.utc,
      :updated_at  => Time.now.utc
    }
  end

  Invoice.new.public_attributes.each do |attribute|
    define_method "find_by_#{attribute}" do |criteria|
      all.find do |object|
        object.send(attribute).to_s.downcase == criteria.to_s.downcase
      end
    end
  end

  Invoice.new.public_attributes.each do |attribute|
    define_method "find_all_by_#{attribute}" do |criteria|
      results = all.find_all do |object|
        object.send(attribute).to_s.downcase == criteria.to_s.downcase
      end
      results ||= []
    end
  end

end
