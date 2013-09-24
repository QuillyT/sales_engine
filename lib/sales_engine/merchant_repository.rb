require 'csv'
require './lib/sales_engine/merchant.rb'

module SalesEngine

  class MerchantRepository

    attr_reader :merchants

    def initialize(filename=nil)
      load(filename)
    end

    def load(filename)
      filename||="./data/merchants.csv"
      merchant_hashes = CSV.read filename, headers: true, header_converters: :symbol
      @merchants = merchant_hashes.collect do |merchant_hash|
        Merchant.new(merchant_hash)
      end
    end

    def find_by_id(search_id)
      @merchants.find { |merchant| merchant.id == search_id }
    end

    def find_by_name(search_name)
      @merchants.find { |merchant| merchant.name == search_name }
    end

    def find_by_created_at(search_time)
      @merchants.find{ |merchant| merchant.created_at == search_time }
    end

    def find_by_updated_at(search_time)
      @merchants.find{ |merchant| merchant.updated_at == search_time }
    end
  end
end
