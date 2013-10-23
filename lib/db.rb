require 'sequel'
require 'sqlite3'

class DB
  attr_reader :dir

  def initialize(dir)
    @dir = dir
  end

  def database
    @database ||= Sequel.sqlite("#{dir}/sales_engine.sqlite3")
  end
end
