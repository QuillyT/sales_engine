require 'csv'
require './test/test_helper'
require './test/sales_engine_stub'
require './lib/merchant.rb'
require './lib/merchant_repository.rb'

class MerchantTest < MiniTest::Test

  def setup
    filename    = './test/fixtures/merchants.csv'
    @engine     = SalesEngineStub.new
    @engine.startup
    @data       = CSV.read filename, headers: true, header_converters: :symbol
    @repository = MerchantRepository.new(filename, @engine)
    @merchant   = Merchant.new(@data[0],@repository)
  end

  def test_it_initializes
    merchant = Merchant.new({})
    assert_kind_of Merchant, merchant
  end

  def test_it_initializes_with_data
    data = {
      id: 1,
      name: "Schroeder-Jerde",
      created_at: "2012-03-27 14:53:59 UTC",
      updated_at: "2012-03-27 14:53:59 UTC"
    }
    merchant = Merchant.new(data)
    assert_equal data[:id],         merchant.id
    assert_equal data[:name],       merchant.name
    assert_equal data[:created_at], merchant.created_at
    assert_equal data[:updated_at], merchant.updated_at
  end

  def test_it_returns_this_merchants_items
    engine = @merchant.repo.engine
    items = engine.item_repository.find_by_merchant_id(@merchant.id)
    assert_equal items, @merchant.items
  end

  def test_it_returns_the_invoices_associated_with_this_merchant
    engine = @merchant.repo.engine
    invoices = engine.invoice_repository.find_by_merchant_id(@merchant.id)
    assert_equal invoices, @merchant.invoices
  end
  
end
