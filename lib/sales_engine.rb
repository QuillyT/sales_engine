require './lib/sales_engine/item_repository.rb'
require './lib/sales_engine/merchant_repository.rb'

module SalesEngine

  class Engine

    attr_reader :item_repository

    def initialize
    end

    def startup
      @item_repository     ||= SalesEngine::ItemRepository.new
      @merchant_repository ||= SalesEngine::MerchantRepository.new
    end

  end
end
