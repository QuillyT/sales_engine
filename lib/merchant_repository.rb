require 'csv'
require_relative 'merchant'
require_relative 'repository_actions'

class MerchantRepository

  include RepositoryActions

  attr_reader :type, :engine

  RepositoryActions::define_find_methods_for(Merchant)

  def initialize(engine, filename = default_filename)
    @type = Merchant
    @engine = engine
    load(filename)
  end

  def default_filename
    "./data/merchants.csv"
  end

  def most_revenue(num = nil)
    num ||= all.count
    all.sort_by { |merchant| merchant.revenue }.reverse[0, num]
  end

  def most_items(num = nil)
    num ||= all.count
    all.sort_by { |merchant| merchant.quantity }.reverse[0, num]
  end

  def revenue(date)
    all.inject(0) { |revenue, merchant| revenue += merchant.revenue(date) }
  end

end
