require './test/test_helper'
require './lib/transaction_repository'

class TransactionRepositoryTest < MiniTest::Test

  def setup
    @fixture = './test/fixtures/transactions.csv'
    @repository = TransactionRepository.new(@fixture)
  end

  def test_it_initializes
    #skip
    #this also means it initializes with no data
    assert_kind_of TransactionRepository, @repository
  end

  def test_it_initializes_with_correct_data
    #skip
    i = @repository.all[0]
    assert_kind_of Transaction, i
    assert_equal 1,                         i.id
    assert_equal 1,                         i.invoice_id
    assert_equal "4654405418249632",        i.credit_card_number
    assert_equal nil,                       i.credit_card_expiration_date
    assert_equal "success",                 i.result
    assert_equal "2012-03-27 14:54:09 UTC", i.created_at
    assert_equal "2012-03-27 14:54:09 UTC", i.updated_at
  end

  def test_find_by_id
    #skip
    item = @repository.find_by_id(10)
    assert_equal 10, item.id
  end

  def test_find_by_invoice_id
    #skip
    id = 1
    item = @repository.find_by_invoice_id(id)
    assert_equal id, item.invoice_id
  end

  def test_find_by_credit_card_number
    #skip
    cc = "4654405418249632"
    item = @repository.find_by_credit_card_number(cc)
    assert_equal cc, item.credit_card_number
  end

  def test_find_by_result
    #skip
    result = "failed"
    item = @repository.find_by_result(result)
    assert_equal result, item.result
  end

  def test_find_by_created_at
    #skip
    time = "2012-03-27 14:54:09 UTC"
    item = @repository.find_by_created_at(time)
    assert_equal time, item.created_at
  end

  def test_find_by_updated_at
    #skip
    time = "2012-03-27 14:54:09 UTC"
    item = @repository.find_by_updated_at(time)
    assert_equal time, item.updated_at
  end

  def test_it_should_return_a_random_instance
    #skip
    item1 = @repository.random
    item2 = @repository.random
    refute_equal item1, item2
  end

  def test_find_all_by_id
    #skip
    items = @repository.find_all_by_id(1)
    assert_equal 1, items.length
  end
  
  def test_find_all_by_invoice_id
    #skip
    items = @repository.find_all_by_invoice_id(2)
    assert_equal 1, items.length
  end
  
  def test_find_all_by_result
    #skip
    items = @repository.find_all_by_result("failed")
    assert_equal 16, items.length
  end

  def test_find_all_by_credit_card_number
    #skip
    cc = "4654405418249632"
    items = @repository.find_all_by_credit_card_number(cc)
    assert_equal 1, items.count
  end

  def test_find_all_by_credit_card_expiration_date
    #skip
    date = ""
    items = @repository.find_all_by_credit_card_expiration_date(date)
    assert_equal 100, items.count
  end

  def test_find_all_by_invoice_id_returns_empty_array_if_empty
    #skip
    items = @repository.find_all_by_invoice_id(999)
    assert_equal [], items
  end

  def test_find_all_by_created_at
    #skip
    date = "2012-03-27 14:54:09 UTC"
    items = @repository.find_all_by_created_at(date)
    assert_equal 2, items.length
  end

  def test_find_all_by_updated_at
    #skip
    date = "2012-03-27 14:54:09 UTC"
    items = @repository.find_all_by_updated_at(date)
    assert_equal 2, items.length
  end

end
