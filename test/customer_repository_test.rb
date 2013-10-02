require './test/test_helper'
require './test/sales_engine_stub'


class CustomerRepositoryTest < MiniTest::Test

  def setup
    @fixture = './test/fixtures/customers.csv'
    @engine              = SalesEngineStub.new
    @repository = CustomerRepository.new(@engine, @fixture)
  end


  def test_it_initializes
    #skip
    #this also means it initializes with no data
    assert_kind_of CustomerRepository, @repository
  end

  def test_it_initializes_with_correct_data
    object = @repository.all[0]
    assert_kind_of Customer, object
    assert_equal 1, object.id
    assert_equal "Joey", object.first_name
    assert_equal "Ondricka", object.last_name
  end

  def test_find_by_id
    #skip
    item = @repository.find_by_id(10)
    assert_equal 10, item.id
  end

  def test_find_by_first_name
    #skip
    name = "Joey"
    item = @repository.find_by_first_name(name)
    assert_equal name, item.first_name
  end

  def test_find_by_last_name
    #skip
    name = "Ondricka"
    item = @repository.find_by_last_name(name)
    assert_equal name, item.last_name
  end

  def test_find_by_case_insensitive_first_name
    #skip
    name = "Joey"
    item = @repository.find_by_first_name(name)
    assert_equal name, item.first_name
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

  def test_find_all_by_first_name
    #skip
    items = @repository.find_all_by_first_name("Joey")
    assert_equal 1, items.length
  end

  def test_find_all_by_first_name_returns_empty_array_if_empty
    #skip
    items = @repository.find_all_by_first_name("goulash...")
    assert_equal [], items
  end

  def test_find_all_by_last_name_returns_empty_array_if_emmpty
    #skip
    items = @repository.find_all_by_last_name("goulash...")
    assert_equal [], items
  end

  def test_find_all_by_created_at
    #skip
    date = "2012-03-27 14:54:09 UTC"
    items = @repository.find_all_by_created_at(date)
    assert_equal 1, items.length
  end

  def test_find_all_by_updated_at
    #skip
    date = "2012-03-27 14:54:09 UTC"
    items = @repository.find_all_by_updated_at(date)
    assert_equal 1, items.length
  end

end
