require './test/test_helper'
require './lib/sales_engine/merchant.rb'

class MerchantTest < MiniTest::Test
  def test_it_initializes
    merchant = SalesEngine::Merchant.new({})
    assert_kind_of SalesEngine::Merchant, merchant
  end
  def test_it_initializes_with_data
    data = {
      id: 1,
      name: "Schroeder-Jerde",
      created_at: "2012-03-27 14:53:59 UTC",
      updated_at: "2012-03-27 14:53:59 UTC"
    }
    merchant = SalesEngine::Merchant.new(data)
    assert_equal data[:id],         merchant.id
    assert_equal data[:name],       merchant.name
    assert_equal data[:created_at], merchant.created_at
    assert_equal data[:updated_at], merchant.updated_at
  end
  
end
