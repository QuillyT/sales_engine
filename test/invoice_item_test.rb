require 'csv'
require './test/test_helper'
require './test/sales_engine_stub'

class InvoiceItemTest < MiniTest::Test

  def setup
    filename = './test/fixtures/invoice_items.csv'
    @engine  = SalesEngineStub.new
    @engine.startup
    @data         = CSV.read filename, headers: true, header_converters: :symbol
    @repository   = InvoiceItemRepository.new(@engine, filename)
    @invoice_item = InvoiceItem.new(@data[0], @repository)
  end

  def test_it_initializes
    invoice_item = InvoiceItem.new
    assert_kind_of InvoiceItem, invoice_item
  end

  def test_it_initializes_with_correct_data
    data = {
      id: 1,
      item_id: 539,
      invoice_id:  1,
      quantity: 5,
      unit_price: 13635,
      created_at: "2012-03-27 14:54:09 UTC",
      updated_at: "2012-03-27 14:54:09 UTC",
    }
    invoice_item = InvoiceItem.new(data)
    p = BigDecimal.new(data[:unit_price].to_s.rjust(3,"0").insert(-3,'.'))
    assert_equal data[:id],         invoice_item.id
    assert_equal data[:item_id],    invoice_item.item_id
    assert_equal data[:invoice_id], invoice_item.invoice_id
    assert_equal data[:quantity],   invoice_item.quantity
    assert_equal p,                 invoice_item.unit_price
    assert_equal data[:created_at], invoice_item.created_at
    assert_equal data[:updated_at], invoice_item.updated_at
  end

  def test_it_returns_instance_of_invoice_associated_with_this_invoice_item
    engine = @invoice_item.repo.engine
    invoice = engine.invoice_repository.find_by_id(@invoice_item.invoice_id)
    assert_equal invoice, @invoice_item.invoice
  end

  def test_it_returns_instance_of_item_associated_with_this_invoice_item
    engine = @invoice_item.repo.engine
    item = engine.item_repository.find_by_id(@invoice_item.item_id)
    assert_equal item, @invoice_item.item
  end

  def test_it_returns_the_total_for_this_invoice_item
    data = BigDecimal.new("681.75")
    assert_equal data, @invoice_item.total
  end
end
