require './lib/sales_engine'

class SalesEngineStub < SalesEngine

  attr_reader :customer_repository, :invoice_repository, 
              :invoice_item_repository, :item_repository, :merchant_repository,
              :transaction_repository
  def startup
    @customer_repository     ||= CustomerRepository.new("./test/fixtures/customers.csv", self)
    @invoice_repository      ||= InvoiceRepository.new("./test/fixtures/invoices.csv", self)
    @invoice_item_repository ||= InvoiceItemRepository.new("./test/fixtures/invoice_items.csv", self)
    @item_repository         ||= ItemRepository.new("./test/fixtures/items.csv", self)
    @merchant_repository     ||= MerchantRepository.new("./test/fixtures/merchants.csv", self)
    @transaction_repository  ||= TransactionRepository.new("./test/fixtures/transactions.csv", self)
  end

end
