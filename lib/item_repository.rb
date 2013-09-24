require './lib/base_repository'
require './lib/item'

class ItemRepository < BaseRepository

  def initialize(filename=nil)
    @type = Item
    load(filename)
  end

  def default_filename
    "./data/items.csv"
  end

end
