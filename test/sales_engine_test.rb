require './test/test_helper'
require './lib/sales_engine'

class EngineTest < MiniTest::Test

  def setup
    @engine = SalesEngine::Engine.new
  end

  def test_it_initializes
    assert_kind_of SalesEngine::Engine, @engine
  end

  def test_it_starts_up
    @engine.startup
    assert_kind_of SalesEngine::ItemRepository, @engine.item_repository 
  end

end
