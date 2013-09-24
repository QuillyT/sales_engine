require './lib/base_repository'
require './lib/customer'

class CustomerRepository < BaseRepository

  def initialize(filename=nil)
    @type = Customer
    load(filename)
  end

  def default_filename
    "./data/customer.csv"
  end

end
