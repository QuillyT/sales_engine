require './lib/item_repository.rb'
require './lib/merchant_repository.rb'

class SalesEngine

  attr_reader :item_repository

  def initialize
  end

  def startup
    @item_repository     ||= ItemRepository.new
    @merchant_repository ||= MerchantRepository.new
  end

end
