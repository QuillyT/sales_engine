require 'csv'
require_relative 'merchant'
require_relative 'repository_actions'
require_relative 'repository_find_generator'

class MerchantRepository

  include RepositoryActions
  extend  RepositoryFindGenerator

  attr_reader :type, :engine

  define_new_find_methods_for(Merchant)
  define_new_find_all_methods_for(Merchant)
  define_id_methods_for(Merchant)

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
    all.sort_by(&:revenue).reverse[0, num]
  end

  def most_items(num = nil)
    num ||= all.count
    all.sort_by(&:quantity).reverse[0, num]
  end

  def revenue(date)
    all.inject(0) { |sum, merchant| sum += merchant.revenue(date) }
  end

  def dates_by_revenue
    sort_sales_dates_by_revenue.collect do |date_revenue_array|
      date_revenue_array[0]
    end
  end

  def all_invoices
    engine.invoice_repository.all
  end

  def unique_sales_dates
    all_invoices.collect(&:created_at_as_date).uniq
  end

  def sales_dates_with_revenues
    unique_sales_dates.each_with_object({}) do |date, revenues|
      revenues[date] = revenue(date)
    end
  end

  def sort_sales_dates_by_revenue
    sales_dates_with_revenues.sort_by { |date, revenue| revenue }.reverse
  end

end
