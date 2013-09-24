require './lib/base_repository'
require './lib/merchant'

class MerchantRepository < BaseRepository

  def initialize(filename=nil)
    @type = Merchant
    load(filename)
  end

  def default_filename
    "./data/merchants.csv"
  end

end
