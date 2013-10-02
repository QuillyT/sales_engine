require 'csv'
require_relative 'invoice_item'
require_relative 'repository_actions'

class InvoiceItemRepository

  include RepositoryActions

  attr_reader :type, :engine

  RepositoryActions::define_find_methods_for(InvoiceItem)

  def initialize(engine, filename = default_filename)
    @type = InvoiceItem
    @engine = engine
    load(filename)
  end

  def default_filename
    "./data/invoice_items.csv"
  end

  def create_invoice_items(invoice_data)
    invoice_item_counts(invoice_data).each do |item, count|
      data = {
        invoice_id: invoice_data[:id],
        item_id: item.id,
        quantity: count,
        unit_price: item.unit_price,
      }
      create(data)
    end
  end

  def invoice_item_counts(invoice_data)
    invoice_data[:items].each_with_object(Hash.new(0)) do |item, counts|
      counts[item] += 1
    end
  end

  def create(data)
    data[:id] = all.count + 1
    data[:created_at] = time_now
    data[:updated_at] = time_now
    invoice_item = InvoiceItem.new(data,self)
    all << invoice_item
    invoice_item
  end

end
