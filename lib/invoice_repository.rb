require './lib/base_repository'
require './lib/invoice'

class InvoiceRepository < BaseRepository

  def initialize(filename=nil)
    @type = Invoice
    load(filename)
  end

  def default_filename
    "./data/invoices.csv"
  end

end
