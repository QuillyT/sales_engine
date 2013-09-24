require './test/test_helper'
require './lib/sales_engine/merchant_repository.rb'

class MerchantRepositoryTest < MiniTest::Test

  def setup
    @fixture = './test/fixtures/merchants.csv'
    @merchant_repository = SalesEngine::MerchantRepository.new(@fixture)
  end

  def test_it_initializes
    #this also means it initializes with no data
    assert_kind_of SalesEngine::MerchantRepository, @merchant_repository
  end

  def test_it_initializes_with_correct_data
    m = @merchant_repository.all[0]
    assert_kind_of SalesEngine::Merchant, m
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
    skip
    merchant_repository = SalesEngine::MerchantRepository.new
    merchants = merchant_repository.find_all_by_id(1)
    assert_equal 1, merchants.length
    assert_equal "Schroeder-Jerde", merchants[0].name
    assert_equal "2012-03-27 14:53:59 UTC", merchants[0].created_at
    assert_equal "2012-03-27 14:53:59 UTC", merchants[0].updated_at
  end
  
  def test_find_all_by_name
    #skip
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
    skip
  end

  def test_find_all_by_updated_at
    skip
  end

end
