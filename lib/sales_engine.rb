require_relative 'customer_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'transaction_repository'

class SalesEngine

  attr_reader :customer_repository, :invoice_repository,
              :invoice_item_repository, :item_repository, :merchant_repository,
              :transaction_repository

  def initialize(dir = nil)
    startup
  end

  def startup
    @customer_repository     ||= CustomerRepository.new(self)
    @invoice_repository      ||= InvoiceRepository.new(self)
    @invoice_item_repository ||= InvoiceItemRepository.new(self)
    @item_repository         ||= ItemRepository.new(self)
    @merchant_repository     ||= MerchantRepository.new(self)
    @transaction_repository  ||= TransactionRepository.new(self)
  end

end
