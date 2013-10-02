require 'csv'
require_relative 'transaction'

class TransactionRepository

  attr_reader :type, :engine

  def initialize(engine, filename = default_filename)
    @type = Transaction
    @engine = engine
    load(filename)
  end

  def default_filename
    "./data/transactions.csv"
  end

  def load(filename)
    @instance_hashes = CSV.read filename, headers: true,
                                header_converters: :symbol
  end

  def all
    @instances ||= create_instances
  end

  def create_instances
    @instance_hashes.collect { |data| type.new(data, self) }
  end

  def random
    all.sample
  end

  def create(transaction_data)
    transaction_data[:id]         = all.count+1
    transaction_data[:created_at] = time_now
    transaction_data[:updated_at] = time_now
    all << Transaction.new(transaction_data, self)
  end

  def time_now
    Time.now.utc
  end

  Transaction.new.public_attributes.each do |attribute|
    define_method "find_by_#{attribute}" do |criteria|
      all.find do |object|
        object.send(attribute).to_s.downcase == criteria.to_s.downcase
      end
    end
  end

  Transaction.new.public_attributes.each do |attribute|
    define_method "find_all_by_#{attribute}" do |criteria|
      results = all.find_all do |object|
        object.send(attribute).to_s.downcase == criteria.to_s.downcase
      end
      results ||= []
    end
  end

end
