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
      @merchants = CSV.read filename, headers: true, header_converters: :symbol
    end

    def find_by_id(search_id)
      result = @merchants.find do |merchant|
        merchant[:id] == search_id.to_s
      end
      Merchant.new(result)
    end

    def find_by_name(search_name)
      result = @merchants.find do |merchant|
        merchant[:name] == search_name
      end
      Merchant.new(result)
    end

  end
end
