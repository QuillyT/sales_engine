require 'sequel'
require 'sqlite3'

class DB
  attr_reader :dir

  def initialize(dir = default_dir)
    @dir = dir
  end

  def default_dir
    "./lib/db"
  end

  def database
    @database ||= Sequel.sqlite("#{dir}/sales_engine.sqlite3")
  end
end
