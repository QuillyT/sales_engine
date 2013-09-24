require './test/test_helper'
require './lib/sales_engine/merchant_repository.rb'

class MerchantRepositoryTest < MiniTest::Test

  def test_it_initializes
    #this also means it initializes with no data
    merchant_repository = SalesEngine::MerchantRepository.new
    assert_kind_of SalesEngine::MerchantRepository, merchant_repository
  end

  def test_it_initializes_with_correct_data
    merchant_repository = SalesEngine::MerchantRepository.new('./data/merchants.csv')
    m = merchant_repository.merchants[0]
    assert_equal "1", m[:id]
    assert_equal "Schroeder-Jerde", m[:name]
    assert_equal "2012-03-27 14:53:59 UTC", m[:created_at]
    assert_equal "2012-03-27 14:53:59 UTC", m[:updated_at]
  end

  def test_find_by_id
    merchant_repository = SalesEngine::MerchantRepository.new
    merchant = merchant_repository.find_by_id(24)
    assert_equal "Ferry and Sons", merchant.name
    assert_equal "2012-03-27 14:54:01 UTC", merchant.created_at
    assert_equal "2012-03-27 14:54:01 UTC", merchant.updated_at
  end

  def test_find_by_first_name
    merchant_repository = SalesEngine::MerchantRepository.new
    merchant = merchant_repository.find_by_name("Klein, Rempel and Jones")
    assert_equal "2", merchant.id
    assert_equal "2012-03-27 14:53:59 UTC", merchant.created_at
    assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
  end

end
