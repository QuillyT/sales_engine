require './test/test_helper'
require './test/sales_engine_stub'
#require './lib/sales_engine'
require './lib/merchant_repository'

class MerchantRepositoryTest < MiniTest::Test

  def setup
    @engine              = SalesEngineStub.new
    @engine.startup
    @fixture             = './test/fixtures/merchants.csv'
    @merchant_repository = @engine.merchant_repository
  end

  def test_it_initializes
    #this also means it initializes with no data
    assert_kind_of MerchantRepository, @merchant_repository
    assert_kind_of SalesEngineStub, @merchant_repository.engine
  end

  def test_it_initializes_with_correct_data
    m = @merchant_repository.all[0]
    assert_kind_of Merchant, m
    assert_equal 1, m.id
    assert_equal "Schroeder-Jerde", m.name
    assert_equal "2012-03-27 14:53:59 UTC", m.created_at
    assert_equal "2012-03-27 14:53:59 UTC", m.updated_at
  end

  def test_find_by_id
    merchant = @merchant_repository.find_by_id(10)
    assert_equal "Bechtelar, Jones and Stokes", merchant.name
    assert_equal "2012-03-27 14:54:00 UTC", merchant.created_at
    assert_equal "2012-03-27 14:54:00 UTC", merchant.updated_at
  end

  def test_find_by_name
    merchant = @merchant_repository.find_by_name("Klein, Rempel and Jones")
    assert_equal 2, merchant.id
    assert_equal "2012-03-27 14:53:59 UTC", merchant.created_at
    assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
  end

  def test_find_by_case_insensitive_name
    merchant = @merchant_repository.find_by_name("kLeIn, rEmPel anD JoNES")
    assert_equal 2, merchant.id
    assert_equal "2012-03-27 14:53:59 UTC", merchant.created_at
    assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
  end

  def test_find_by_created_at
    merchant = @merchant_repository.find_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal 1, merchant.id
    assert_equal "Schroeder-Jerde", merchant.name
    assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
  end

  def test_find_by_updated_at
    merchant = @merchant_repository.find_by_updated_at("2012-03-27 14:53:59 UTC")
    assert_equal 1, merchant.id
    assert_equal "Schroeder-Jerde", merchant.name
    assert_equal "2012-03-27 14:53:59 UTC", merchant.created_at
  end

  def test_it_should_return_a_random_instance
    merchant1 = @merchant_repository.random
    merchant2 = @merchant_repository.random
    refute_equal merchant1, merchant2
  end

  def test_find_all_by_id
    merchants = @merchant_repository.find_all_by_id(1)
    assert_equal 1, merchants.length
    assert_equal "Schroeder-Jerde", merchants[0].name
    assert_equal "2012-03-27 14:53:59 UTC", merchants[0].created_at
    assert_equal "2012-03-27 14:53:59 UTC", merchants[0].updated_at
  end
  
  def test_find_all_by_name
    merchants = @merchant_repository.find_all_by_name("Schroeder-Jerde")
    assert_equal 1, merchants.length
    assert_equal "Schroeder-Jerde", merchants[0].name
    assert_equal "2012-03-27 14:53:59 UTC", merchants[0].created_at
    assert_equal "2012-03-27 14:53:59 UTC", merchants[0].updated_at
  end

  def test_find_all_by_name_returns_empty_array_if_empty
    merchants = @merchant_repository.find_all_by_name("goulash...")
    assert_equal [], merchants
  end

  def test_find_all_by_created_at
    date = "2012-03-27 14:53:59 UTC"
    merchants = @merchant_repository.find_all_by_created_at(date)
    assert_equal 9, merchants.length
    assert_equal "Schroeder-Jerde", merchants[0].name
    assert_equal "2012-03-27 14:53:59 UTC", merchants[0].created_at
    assert_equal "2012-03-27 14:53:59 UTC", merchants[0].updated_at
  end

  def test_find_all_by_updated_at
    date = "2012-03-27 14:53:59 UTC"
    merchants = @merchant_repository.find_all_by_updated_at(date)
    assert_equal 8, merchants.length
    assert_equal "Schroeder-Jerde", merchants[0].name
    assert_equal "2012-03-27 14:53:59 UTC", merchants[0].created_at
    assert_equal "2012-03-27 14:53:59 UTC", merchants[0].updated_at
  end

end
