require 'sequel'
require 'sqlite3'

module DB
  class << self
    attr_writer :dir
  end

  def self.dir
    if ENV['sales_engine'] != "test"
      "./lib/db"
    else
      "./test/db"
    end
  end

  def self.database
    @database ||= Sequel.sqlite("#{dir}/sales_engine.sqlite3")
  end
end
