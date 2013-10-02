require 'csv'
require_relative 'item'

class ItemRepository

  attr_reader :type, :engine

  def initialize(engine, filename = default_filename)
    @type = Item
    @engine = engine
    load(filename)
  end

  def default_filename
    "./data/items.csv"
  end

  def load(filename)
    @instance_hashes = CSV.read filename, headers: true,
                                header_converters: :symbol
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

  def most_items(num)
    num ||= all.count
    all.sort_by { |item| item.quantity_sold }.reverse[0,num]
  end

  def most_revenue(num)
    num ||= all.count
    all.sort_by { |item| item.revenue }.reverse[0, num]
  end

  Item.new.public_attributes.each do |attribute|
    define_method "find_by_#{attribute}" do |criteria|
      all.find do |object|
        object.send(attribute).to_s.downcase == criteria.to_s.downcase
      end
    end
  end

  Item.new.public_attributes.each do |attribute|
    define_method "find_all_by_#{attribute}" do |criteria|
      results = all.find_all do |object|
        object.send(attribute).to_s.downcase == criteria.to_s.downcase
      end
      results ||= []
    end
  end

end
