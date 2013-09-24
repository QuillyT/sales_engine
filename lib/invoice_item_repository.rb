require './lib/base_repository'
require './lib/invoice_item'

class InvoiceItemRepository < BaseRepository

  def initialize(filename=nil)
    @type = InvoiceItem
    load(filename)
  end

  def default_filename
    "./data/invoice_items.csv"
  end

end
