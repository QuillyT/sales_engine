require 'csv'
require './test/test_helper'
require './test/sales_engine_stub'

class CustomerTest < MiniTest::Test

  def setup
    filename        = './test/fixtures/customers.csv'
    @engine         = SalesEngineStub.new
    @engine.startup
    @data           = CSV.read filename, headers: true, header_converters: :symbol
    @repository     = CustomerRepository.new(filename, @engine)
    @customer        = Customer.new(@data[0], @repository)
  end

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

  def test_it_returns_a_collection_of_invoices
    count = 8
    assert_equal count, @customer.invoices.count
  end

  def test_it_returns_an_array_of_its_transactions
    count = 7 
    assert_equal count, @customer.transactions.count
  end

  def test_it_returns_this_customers_favorite_merchant
    merchant_id = 26
    assert_equal merchant_id, @customer.favorite_merchant.id
  end

end
