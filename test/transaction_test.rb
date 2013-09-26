require 'csv'
require './test/test_helper'
require './test/sales_engine_stub'

class TransactionTest < MiniTest::Test

  def setup
    filename        = './test/fixtures/items.csv'
    @engine         = SalesEngineStub.new
    @engine.startup
    @data           = CSV.read filename, headers: true, header_converters: :symbol
    @repository     = TransactionRepository.new(filename, @engine)
    @transaction    = Transaction.new(@data[0], @repository)
  end

  def test_it_initializes
    transaction = Transaction.new
    assert_kind_of Transaction, transaction
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

  def test_returns_an_associated_instance_of_invoice
    engine = @transaction.repo.engine
    invoice = engine.invoice_repository.find_by_id(@transaction.invoice_id)
    assert_equal invoice, @transaction.invoice
  end
end
