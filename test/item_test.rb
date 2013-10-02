require 'csv'
require './test/test_helper'
require './test/sales_engine_stub'


class ItemTest < MiniTest::Test

  def setup
    filename        = './test/fixtures/items.csv'
    @engine         = SalesEngineStub.new
    @engine.startup
    @data           = CSV.read filename, headers: true, header_converters: :symbol
    @repository     = ItemRepository.new(@engine, filename)
    @item           = Item.new(@data[0], @repository)
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
    p = BigDecimal.new(data[:unit_price].to_s.rjust(3, "0").insert(-3, '.'))
    item = Item.new(data)
    assert_equal data[:id],          item.id
    assert_equal data[:name],        item.name
    assert_equal data[:description], item.description
    assert_equal p,                  item.unit_price
    assert_equal data[:merchant_id], item.merchant_id
    assert_equal data[:created_at],  item.created_at
    assert_equal data[:updated_at],  item.updated_at
  end

  def test_it_returns_invoice_items_for_this_item
    count = 1  
    assert_equal count, @item.invoice_items.count
  end

  def test_it_returns_the_merchant_for_this_item
    merchant_id = 1
    assert_equal merchant_id, @item.merchant.id
  end

  def test_it_returns_the_best_day_for_this_item
    date = Date.parse "2012-03-25 13:54:11 UTC"
    assert_equal date, @item.best_day
  end

end
