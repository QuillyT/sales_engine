require 'csv'
require_relative 'transaction'
require_relative 'repository_actions'

class TransactionRepository

  include RepositoryActions

  attr_reader :type, :engine

  RepositoryActions::define_find_methods_for(Transaction)

  def initialize(engine, filename = default_filename)
    @type = Transaction
    @engine = engine
    load(filename)
  end

  def default_filename
    "./data/transactions.csv"
  end

  def create(transaction_data)
    transaction_data[:id]         = all.count+1
    transaction_data[:created_at] = time_now
    transaction_data[:updated_at] = time_now
    all << Transaction.new(transaction_data, self)
  end

end
