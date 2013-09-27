require './lib/customer_repository'
require './lib/invoice_repository'
require './lib/invoice_item_repository'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/transaction_repository'

class SalesEngine

  attr_reader :customer_repository, :invoice_repository, 
              :invoice_item_repository, :item_repository, :merchant_repository,
              :transaction_repository

  def initialize
  end

  def startup
    @customer_repository     ||= CustomerRepository.new(nil, self)
    @invoice_repository      ||= InvoiceRepository.new(nil, self)
    @invoice_item_repository ||= InvoiceItemRepository.new(nil, self)
    @item_repository         ||= ItemRepository.new(nil, self)
    @merchant_repository     ||= MerchantRepository.new(nil, self)
    @transaction_repository  ||= TransactionRepository.new(nil, self)
  end

end
