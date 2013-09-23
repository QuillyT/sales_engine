require './test/test_helper'
require './lib/sales_engine/invoice.rb'

class InvoiceTest < MiniTest::Test

  def test_it_initializes
    invoice = SalesEngine::Invoice.new
    assert_kind_of SalesEngine::Invoice, invoice
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
    invoice = SalesEngine::Invoice.new(data)

    assert_equal data[:id],          invoice.id
    assert_equal data[:customer_id], invoice.customer_id
    assert_equal data[:merchant_id], invoice.merchant_id
    assert_equal data[:status],      invoice.status
    assert_equal data[:created_at],  invoice.created_at
    assert_equal data[:updated_at],  invoice.updated_at
  end

end
