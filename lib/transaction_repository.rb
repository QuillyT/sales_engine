require './lib/base_repository'
require './lib/transaction'

class TransactionRepository < BaseRepository

  def initialize(filename=nil)
    @type = Transaction
    load(filename)
  end

  def default_filename
    "./data/transactions.csv"
  end

end
