require 'csv'
require './test/test_helper'
require './test/sales_engine_stub'

class ItemTest < MiniTest::Test

  def setup
    filename        = './test/fixtures/items.csv'
    @engine         = SalesEngineStub.new
    @engine.startup
    @data           = CSV.read filename, headers: true, header_converters: :symbol
    @repository     = ItemRepository.new(filename, @engine)
    @item    = Item.new(@data[0], @repository)
  end

  def test_it_initializes
    item = Item.new({})
    assert_kind_of Item, item
  end

  def test_it_initializes_with_data
    data = {
      id: 1,
      name: "Item Qui Esse",
      description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.",
      unit_price: 75107,
      merchant_id: 1,
      created_at: "2012-03-27 14:54:09 UTC",
      updated_at: "2012-03-27 14:53:59 UTC",
    }
    item = Item.new(data)
    assert_equal data[:id],          item.id
    assert_equal data[:name],        item.name
    assert_equal data[:description], item.description
    assert_equal data[:unit_price],  item.unit_price
    assert_equal data[:merchant_id], item.merchant_id
    assert_equal data[:created_at],  item.created_at
    assert_equal data[:updated_at],  item.updated_at
  end

  def test_returns_a_collection_of_associated_invoice_items
    engine = @item.repo.engine
    invoice_items = engine.invoice_item_repository.find_all_by_item_id(@item.id)
    assert_equal invoice_items, @item.invoice_items
  end

  def test_returns_an_instance_of_merchant_associated_items_object
    engine = @item.repo.engine
    merchant = engine.merchant_repository.find_by_id(@item.merchant_id)
    assert_equal merchant, @item.merchant
  end
end
