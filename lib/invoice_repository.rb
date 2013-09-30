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
