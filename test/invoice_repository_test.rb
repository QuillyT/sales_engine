require './test/test_helper'
require './lib/invoice_repository.rb'

class InvoiceRepositoryTest < MiniTest::Test

  def setup
    @fixture = './test/fixtures/invoices.csv'
    @invoice_repository = InvoiceRepository.new(@fixture)
  end

  def test_it_initializes
    #this also means it initializes with no data
    assert_kind_of InvoiceRepository, @invoice_repository
  end

  def test_it_initializes_with_correct_data
    object = @invoice_repository.all[0]
    assert_kind_of Invoice, object
    assert_equal 1, object.id
    assert_equal 1, object.customer_id
    assert_equal 26, object.merchant_id
    assert_equal "shipped", object.status
  end

  def test_find_by_id
    invoice = @invoice_repository.find_by_id(1)
    assert_equal 1, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 26, invoice.merchant_id
  end

  def test_find_by_customer_id
    invoice = @invoice_repository.find_by_customer_id(1)
    assert_equal 1, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 26, invoice.merchant_id
  end

  def test_find_by_merchant_id
    invoice = @invoice_repository.find_by_merchant_id(26)
    assert_equal 1, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 26, invoice.merchant_id
  end

  def test_find_by_status
    invoice = @invoice_repository.find_by_status("shipped")
    assert_equal 1, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 26, invoice.merchant_id
  end

  def test_find_by_updated_at
    invoice = @invoice_repository.find_by_updated_at("2012-03-25 09:54:09 UTC")
    assert_equal 1, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 26, invoice.merchant_id
  end

  def test_it_should_return_a_random_instance
    invoice1 = @invoice_repository.random
    invoice2 = @invoice_repository.random
    refute_equal invoice1, invoice2
  end

  def test_find_all_by_id
    invoices = @invoice_repository.find_all_by_id(1)
    assert_equal 1, invoices.length
  end

  def test_find_all_by_customer_id
    invoices = @invoice_repository.find_all_by_customer_id(1)
    assert_equal 8, invoices.length
  end

  def test_find_all_by_merchant_id
    invoices = @invoice_repository.find_all_by_merchant_id(1)
    assert_equal 1, invoices.length
  end

  def test_find_all_by_customer_id_returns_empty_array_if_empty
    invoices = @invoice_repository.find_all_by_customer_id(12345)
    assert_equal [], invoices
  end

  def test_find_all_by_created_at
    date = "2012-03-25 09:54:09 UTC"
    invoices = @invoice_repository.find_all_by_created_at(date)
    assert_equal 1, invoices.length
  end

  def test_find_all_by_updated_at
    date = "2012-03-25 09:54:09 UTC"
    invoices = @invoice_repository.find_all_by_updated_at(date)
    assert_equal 1, invoices.length
  end

end
