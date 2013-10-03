require 'csv'
require_relative 'customer'
require_relative 'repository_actions'
require_relative 'repository_find_generator'

class CustomerRepository

  include RepositoryActions
  extend  RepositoryFindGenerator

  attr_reader :type, :engine

  define_new_find_methods_for(Customer)
  define_new_find_all_methods_for(Customer)
  define_id_methods_for(Customer)

  def initialize(engine, filename = default_filename)
    @type   = Customer
    @engine = engine
    load(filename)
  end

  def default_filename
    "./data/customers.csv"
  end

end
