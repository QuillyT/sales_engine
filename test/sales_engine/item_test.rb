require './test/test_helper'
require './lib/sales_engine/item.rb'

class ItemTest < MiniTest::Test

  def test_it_initializes
    item = SalesEngine::Item.new({})
    assert_kind_of SalesEngine::Item, item
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
    item = SalesEngine::Item.new(data)
    assert_equal data[:id],          item.id
    assert_equal data[:name],        item.name
    assert_equal data[:description], item.description
    assert_equal data[:unit_price],  item.unit_price
    assert_equal data[:merchant_id], item.merchant_id
    assert_equal data[:created_at],  item.created_at
    assert_equal data[:updated_at],  item.updated_at
  end

end
