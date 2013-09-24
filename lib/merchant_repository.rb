require 'csv'
require './lib/merchant.rb'

class MerchantRepository

  def initialize(filename=nil)
    @type = Merchant
    load(filename)
  end

  def load(filename)
    filename ||= default_filename
    @instance_hashes = CSV.read filename, headers: true, header_converters: :symbol
  end

  def default_filename
    "./data/merchants.csv"
  end

  def type
    @type
  end

  def all
    @instances ||= create_instances
  end

  def create_instances
    @instance_hashes.collect { |data| @type.new(data) }
  end

  def find_by_attribute(attribute, criteria)
    all.find do |object|
      object.send(attribute).to_s.downcase == criteria.to_s.downcase
    end
  end

  def find_by_id(search_id)
    find_by_attribute(:id, search_id)
  end

  def find_by_name(search_name)
    find_by_attribute(:name, search_name)
  end

  def find_by_created_at(search_time)
    find_by_attribute(:created_at, search_time)
  end

  def find_by_updated_at(search_time)
    find_by_attribute(:updated_at, search_time)
  end
  
  def random
    all.sample
  end

  def find_all_by_attribute(attribute, criteria)
    results = all.find_all do |object|
      object.send(attribute).to_s.downcase == criteria.to_s.downcase
    end
    results ||= []
  end

  def find_all_by_id(search_id)
    find_all_by_attribute(:id, search_id)
  end

  def find_all_by_name(search_name)
    find_all_by_attribute(:name, search_name)
  end

  def find_all_by_created_at(search_time)
    find_all_by_attribute(:created_at, search_time)
  end

  def find_all_by_updated_at(search_time)
    find_all_by_attribute(:updated_at, search_time)
  end
end
