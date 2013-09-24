require './test/test_helper'
require './lib/sales_engine/item_repository.rb'

class ItemRepositoryTest < MiniTest::Test

  def setup
    @fixture = './test/fixtures/items.csv'
    @repository = SalesEngine::ItemRepository.new(@fixture)
  end

  def test_it_initializes
    #skip
    #this also means it initializes with no data
    assert_kind_of SalesEngine::ItemRepository, @repository
  end

  def test_it_initializes_with_correct_data
    #skip
    i = @repository.all[0]
    assert_kind_of SalesEngine::Item, i
    assert_equal 1, i.id
    assert_equal "Item Qui Esse", i.name
    assert_equal "2012-03-27 14:53:59 UTC", i.created_at
    assert_equal "2012-03-27 14:53:59 UTC", i.updated_at
  end

  def test_find_by_id
    #skip
    item = @repository.find_by_id(10)
    assert_equal 10, item.id
  end

  def test_find_by_name
    #skip
    name = "Item Qui Esse"
    item = @repository.find_by_name(name)
    assert_equal name, item.name
  end

  def test_find_by_case_insensitive_name
    #skip
    name = "Item Qui Esse"
    item = @repository.find_by_name("item qui esse")
    assert_equal name, item.name
  end

  def test_find_by_created_at
    #skip
    time = "2012-03-27 14:53:59 UTC" 
    item = @repository.find_by_created_at(time)
    assert_equal time, item.created_at
  end

  def test_find_by_updated_at
    #skip
    time = "2012-03-27 14:53:59 UTC" 
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
  
  def test_find_all_by_name
    #skip
    items = @repository.find_all_by_name("Item Qui Esse")
    assert_equal 1, items.length
  end

  def test_find_all_by_name_returns_empty_array_if_empty
    #skip
    items = @repository.find_all_by_name("goulash...")
    assert_equal [], items
  end

  def test_find_all_by_created_at
    #skip
    date = "2012-03-27 14:53:59 UTC"
    items = @repository.find_all_by_created_at(date)
    assert_equal 20, items.length
  end

  def test_find_all_by_updated_at
    #skip
    date = "2012-03-27 14:53:59 UTC"
    items = @repository.find_all_by_updated_at(date)
    assert_equal 20, items.length
  end

end
