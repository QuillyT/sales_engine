require './test/test_helper'
require './lib/customer.rb'

class CustomerTest < MiniTest::Test

  def test_it_initializes
    customer = Customer.new
    assert_kind_of Customer, customer
  end

  def test_it_initializes_with_correct_data
    data = { 
      id: 1,
      first_name: "Joey",
      last_name:  "Ondricka",
      updated_at: "2012-03-27 14:54:09 UTC",
      created_at: "2012-03-27 14:54:09 UTC"
    }
    customer = Customer.new(data)
    assert_equal data[:id],         customer.id
    assert_equal data[:first_name], customer.first_name
    assert_equal data[:last_name],  customer.last_name
    assert_equal data[:created_at], customer.created_at
    assert_equal data[:updated_at], customer.updated_at
  end

end
