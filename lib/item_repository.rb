require './lib/base_repository'
require './lib/item'

class ItemRepository < BaseRepository

  def initialize(filename=nil)
    @filename = filename || default_filename
    @type = Item
    puts @type
    load(filename)
  end

  def default_filename
    "./data/items.csv"
  end

  generate_find_methods

end
