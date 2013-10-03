require 'csv'
require_relative 'item'
require_relative 'repository_actions'
require_relative 'repository_find_generator'

class ItemRepository

  include RepositoryActions
  extend  RepositoryFindGenerator

  attr_reader :type, :engine

  define_find_methods_for(Item)

  def initialize(engine, filename = default_filename)
    @type = Item
    @engine = engine
    load(filename)
  end

  def default_filename
    "./data/items.csv"
  end

  def most_items(num)
    num ||= all.count
    all.sort_by(&:quantity_sold).reverse[0,num]
  end

  def most_revenue(num)
    num ||= all.count
    all.sort_by(&:revenue).reverse[0, num]
  end

end
