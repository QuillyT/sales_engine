require 'csv'
require './lib/invoice_item'

class InvoiceItemRepository

  attr_reader :type

  def initialize(filename=nil)
    @type = InvoiceItem
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
    @instance_hashes.collect { |data| type.new(data) }
  end

  def random
    all.sample
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
