require './test/test_helper'
require './test/sales_engine_stub'

class TransactionTest < MiniTest::Test

  def setup
    engine         = SalesEngineStub.new
    engine.startup
    filename       = "./test/fixtures/transactions.csv"
    repo           = engine.transaction_repository
    @transaction   = repo.all.first
  end

  def test_it_initializes
    assert_kind_of Transaction, @transaction
  end

  def test_it_initializes_with_d
    d = {
      id: 1,
      invoice_id: 1,
      credit_card_number: "4654405418249632",
      credit_card_expiration_date: nil,
      result: "success",
      created_at: "2012-03-27 14:54:09 UTC",
      updated_at: "2012-03-27 14:54:09 UTC",
    }
    t = Transaction.new(d)

    assert_equal d[:id],                          t.id
    assert_equal d[:invoice_id],                  t.invoice_id
    assert_equal d[:credit_card_number],          t.credit_card_number
    assert_equal d[:credit_card_expiration_date], t.credit_card_expiration_date
    assert_equal d[:result],                      t.result
    assert_equal d[:created_at],                  t.created_at
    assert_equal d[:updated_at],                  t.updated_at
  end

  def test_it_returns_the_invoice_for_this_transaction
    invoice_id = 1
    assert_equal invoice_id, @transaction.invoice.id
  end
end
