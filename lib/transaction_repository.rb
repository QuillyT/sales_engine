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

  Item.new.public_attributes.each do |attribute|
    define_method "find_by_#{attribute}" do |criteria|
      all.find do |object|
        object.send(attribute).to_s.downcase == criteria.to_s.downcase
      end
    end
  end

  Item.new_public_attributes.each do |attribute|
    define_method "find_by_#{attribute}" do |criteria|
      results = all.find_all do |object|
        object.send(attribute).to_s.downcase == criteria.to_s.downcase
      end
      results ||= []
    end
  end
end
