require './test/test_helper'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < MiniTest::Test

  def setup
    @fixture = './test/fixtures/invoice_items.csv'
    @repository = InvoiceItemRepository.new(@fixture)
  end

  def test_it_initializes
    #skip
    #this also means it initializes with no data
    assert_kind_of InvoiceItemRepository, @repository
  end

  def test_it_initializes_with_correct_data
    #skip
    i = @repository.all[0]
    assert_kind_of InvoiceItem, i
    assert_equal 1, i.id
    assert_equal 539, i.item_id
    assert_equal 1, i.invoice_id
    assert_equal 5, i.quantity
    assert_equal 13635, i.unit_price
    assert_equal "2012-03-27 14:54:09 UTC", i.created_at
    assert_equal "2012-03-27 14:54:09 UTC", i.updated_at
  end

  def test_find_by_id
    #skip
    item = @repository.find_by_id(10)
    assert_equal 10, item.id
  end

  def test_find_by_item_id
    #skip
    id = 539
    item = @repository.find_by_item_id(id)
    assert_equal id, item.item_id
  end

  def test_find_by_invoice_id
    #skip
    id = 1
    item = @repository.find_by_invoice_id(id)
    assert_equal id, item.invoice_id
  end

  def test_find_by_quantity
    #skip
    quantity = 5
    item = @repository.find_by_quantity(quantity)
    assert_equal quantity, item.quantity
  end

  def test_find_by_unit_price
    #skip
    price = 13635
    item = @repository.find_by_unit_price(price)
    assert_equal price, item.unit_price
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
  
  def test_find_all_by_item_id
    #skip
    items = @repository.find_all_by_item_id(539)
    assert_equal 1, items.length
  end

  def test_find_all_by_invoice_id
    #skip
    items = @repository.find_all_by_invoice_id(2)
    assert_equal 4, items.length
  end

  def test_find_all_by_quantity
    items = @repository.find_all_by_quantity(6)
    assert_equal 2, items.count
  end

  def test_find_all_by_unit_price
    items = @repository.find_all_by_unit_price(72018)
    assert_equal 3, items.count
  end

  def test_find_all_by_item_id_returns_empty_array_if_empty
    #skip
    items = @repository.find_all_by_item_id(999)
    assert_equal [], items
  end

  def test_find_all_by_created_at
    #skip
    date = "2012-03-27 14:54:09 UTC"
    items = @repository.find_all_by_created_at(date)
    assert_equal 15, items.length
  end

  def test_find_all_by_updated_at
    #skip
    date = "2012-03-27 14:54:09 UTC"
    items = @repository.find_all_by_updated_at(date)
    assert_equal 15, items.length
  end

end
