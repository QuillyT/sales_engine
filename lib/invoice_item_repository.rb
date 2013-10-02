require 'csv'
require_relative 'invoice_item'

class InvoiceItemRepository

  attr_reader :type, :engine

  def initialize(filename=nil, engine = nil)
    @type = InvoiceItem
    @engine = engine
    load(filename)
  end

  def default_filename
    "./data/invoice_items.csv"
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
    data[:created_at] = Time.now.utc
    data[:updated_at] = Time.now.utc
    invoice_item = InvoiceItem.new(data,self)
    all << invoice_item
    invoice_item
  end

  InvoiceItem.new.public_attributes.each do |attribute|
    define_method "find_by_#{attribute}" do |criteria|
      all.find do |object|
        object.send(attribute).to_s.downcase == criteria.to_s.downcase
      end
    end
  end

  InvoiceItem.new.public_attributes.each do |attribute|
    define_method "find_all_by_#{attribute}" do |criteria|
      results = all.find_all do |object|
        object.send(attribute).to_s.downcase == criteria.to_s.downcase
      end
      results ||= []
    end
  end
end
