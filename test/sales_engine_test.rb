require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < MiniTest::Test

  def setup
    @engine = SalesEngine.new
  end

  def test_it_initializes
    assert_kind_of SalesEngine, @engine
  end

  def test_it_starts_up
    @engine.startup
    assert_kind_of ItemRepository, @engine.item_repository 
  end

end
