require 'csv'
require './test/test_helper'
require './test/sales_engine_stub'

class InvoiceTest < MiniTest::Test

  def setup
    filename        = './test/fixtures/invoices.csv'
    @engine         = SalesEngineStub.new
    @engine.startup
    @data           = CSV.read filename, headers: true, header_converters: :symbol
    @repository     = InvoiceRepository.new(@engine, filename)
    @invoice        = Invoice.new(@data[0], @repository)
  end

  def test_it_initializes
    invoice = Invoice.new
    assert_kind_of Invoice, invoice
  end

  def test_it_initializes_with_correct_data
    data = {
      id: 1,
      customer_id: 1,
      merchant_id: 26,
      status: "shipped",
      created_at: "2012-03-25 09:54:09 UTC",
      updated_at: "2012-03-25 09:54:09 UTC",
    }
    invoice = Invoice.new(data)

    assert_equal data[:id],          invoice.id
    assert_equal data[:customer_id], invoice.customer_id
    assert_equal data[:merchant_id], invoice.merchant_id
    assert_equal data[:status],      invoice.status
    assert_equal data[:created_at],  invoice.created_at
    assert_equal data[:updated_at],  invoice.updated_at
  end

  def test_it_returns_transactions_associated_with_this_invoice
    engine = @invoice.repo.engine
    trans = engine.transaction_repository.find_all_by_invoice_id(@invoice.id)
    assert_equal trans, @invoice.transactions
  end

  def test_it_returns_invoice_items_associated_with_this_invoice
    engine = @invoice.repo.engine
    items = engine.invoice_item_repository
                     .find_all_by_invoice_id(@invoice.id)
    assert_equal items, @invoice.invoice_items
  end

  def test_it_returns_the_customer_associated_with_this_invoice
    engine = @invoice.repo.engine
    customer = engine.customer_repository.find_by_id(@invoice.customer_id)
    assert_equal customer, @invoice.customer
  end

  def test_it_returns_the_merchant_associated_with_this_invoice
    engine = @invoice.repo.engine
    merchant = engine.merchant_repository.find_by_id(@invoice.merchant_id)
    assert_equal merchant, @invoice.merchant
  end

  def test_it_returns_items_associated_with_this_invoice_from_invoice_items
    engine = @invoice.repo.engine
    invoice_items = @invoice.invoice_items
    items = invoice_items.collect do |invoice_item|
      engine.item_repository.find_by_id(invoice_item.item_id)
    end
    assert_equal items, @invoice.items
  end

  def test_it_returns_the_total_for_this_invoice
    total = BigDecimal.new("21067.77")
    assert_equal total, @invoice.total
  end

  def test_it_returns_true_if_successful
    assert @invoice.successful?, "Expected invoice to be successful"
  end

  def test_it_returns_false_if_failed
    invoice = Invoice.new(@data[12], @repository)
    refute invoice.successful?, "Expected invoice to not be successful"
  end

  def test_it_returns_the_total_quantity_of_its_invoice_items
    invoice = Invoice.new(@data[0], @repository)
    quantity = 47
    assert_equal quantity, invoice.quantity
  end

  def test_it_returns_true_if_pending
    failed_invoice = Invoice.new(@data[12], @repository)
    assert failed_invoice.pending?, "Expected invoice to be pending" 
    refute @invoice.pending?, "Expected invoice to be pending"
  end

  def test_it_creates_transactions
    count = @engine.transaction_repository.all.count
    charge_data  = { credit_card_number: "4444333322221111", 
                     credit_card_expiration: "10/13", 
                     result: 'success' }
    invoice_data = { id: @repository.all.count+1 }
    invoice      = Invoice.new(invoice_data,@repository)
    invoice.charge(charge_data)
    new_transactions = @engine.transaction_repository.all
    assert_equal count+1, new_transactions.count
    assert_equal invoice.id, new_transactions.last.invoice_id
  end



end
