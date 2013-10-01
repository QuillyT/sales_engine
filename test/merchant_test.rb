require 'csv'
require './test/test_helper'
require './test/sales_engine_stub'

class MerchantTest < MiniTest::Test

  def setup
    filename    = './test/fixtures/merchants.csv'
    @engine     = SalesEngineStub.new
    @engine.startup
    @data       = CSV.read filename, headers: true, header_converters: :symbol
    @repository = MerchantRepository.new(filename, @engine)
    @merchant   = Merchant.new(@data[0], @repository)
  end

  def test_it_initializes
    merchant = Merchant.new({})
    assert_kind_of Merchant, merchant
  end

  def test_it_initializes_with_data
    data = {
      id: 1,
      name: "Schroeder-Jerde",
      created_at: "2012-03-27 14:53:59 UTC",
      updated_at: "2012-03-27 14:53:59 UTC"
    }
    merchant = Merchant.new(data)
    assert_equal data[:id],         merchant.id
    assert_equal data[:name],       merchant.name
    assert_equal data[:created_at], merchant.created_at
    assert_equal data[:updated_at], merchant.updated_at
  end

  def test_it_returns_this_merchants_items
    engine = @merchant.repo.engine
    items = engine.item_repository.find_all_by_merchant_id(@merchant.id)
    assert_equal items.count, @merchant.items.count
  end

  def test_it_returns_the_invoices_associated_with_this_merchant
    engine   = @merchant.repo.engine
    invoices = engine.invoice_repository.find_all_by_merchant_id(@merchant.id)
    assert_equal invoices.count, @merchant.invoices.count
  end

  def test_it_returns_an_array_of_successful_invoices
    count    = 1
    merchant = Merchant.new(@data[33], @repository)
    assert_equal count, merchant.successful_invoices.length
  end

  def test_it_returns_the_revenue_for_this_merchant
    #skip
    merchant = Merchant.new(@data[33], @repository)
    cents    = BigDecimal.new("10634.22")
    assert_equal cents, merchant.revenue
  end

  def test_it_returns_successful_invoice_revenue
    merchant = Merchant.new(@data[33], @repository)
    cents    = 1063422
    assert_equal cents, merchant.successful_invoices_revenue
  end

  def test_it_returns_successful_invoice_revenue_by_date
    date = Date.parse "2012-03-25 09:54:09 UTC"
    merchant = Merchant.new(@data[0], @repository)
    cents= 1281794
    assert_equal cents, merchant.date_invoices_revenue(date)
  end
  
  def test_it_returns_the_correct_quantity
    merchant = Merchant.new(@data[0], @repository)
    quantity = 37
    assert_equal quantity, merchant.quantity
  end

  def test_it_returns_big_decimal
    value = 1234567
    decimal = BigDecimal.new("12345.67")
    assert_equal decimal, @merchant.currency_for(value)
  end

  def test_it_returns_revenue_for_date
    merchant = Merchant.new(@data[0], @repository)
    date = Date.parse "2012-03-25 09:54:09 UTC"
    #date = Date.parse "Fri, 09 Mar 2012"
    total_revenue = BigDecimal("12817.94")
    assert_equal total_revenue, merchant.revenue(date)
  end

  def test_it_returns_the_favorite_customer
    merchant = Merchant.new(@data[0], @repository)
    customer_id = 7
    assert_equal customer_id, merchant.favorite_customer.id
  end

  def test_it_counts_the_customers_with_invoice_counts
    merchant = Merchant.new(@data[0], @repository)
    data = { 7 => 1 }
    assert_equal data, merchant.customer_counts
  end

  def test_it_gets_the_favorite_customer_id
    merchant = Merchant.new(@data[0], @repository)
    id = 7
    assert_equal id, merchant.favorite_customer_id
  end

  def test_it_returns_customers_who_have_pending_invoices
    merchant = Merchant.new(@data[55], @repository)
    pending_count = 1
    assert_equal pending_count, merchant.customers_with_pending_invoices.count
  end

end
