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
    @customer_repository     ||= CustomerRepository.new(nil, self)
    @invoice_repository      ||= InvoiceRepository.new(nil, self)
    @invoice_item_repository ||= InvoiceItemRepository.new(nil, self)
    @item_repository         ||= ItemRepository.new(nil, self)
    @merchant_repository     ||= MerchantRepository.new(nil, self)
    @transaction_repository  ||= TransactionRepository.new(nil, self)
  end

end
