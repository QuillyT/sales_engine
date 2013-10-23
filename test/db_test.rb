require './test/test_helper'
require './lib/db'

class DBTest < Minitest::Test

  attr_reader :db

  def setup
    @db = DB.database
  end

  def teardown
    DB.destroy
  end

  def file
    "./test/fixtures/merchants.csv"
  end

  def test_it_exists
    assert DB
  end

  def test_it_has_a_directory
    assert_equal './test/db', DB.dir
  end

  def test_it_creates_a_new_db
    file = './test/db/sales_engine.sqlite3'
    refute File.exists?(file)

    db = DB.database
    db.create_table :test do
      primary_key :id
      String      :name
      Float       :price
    end

    assert File.exists?(file),
      "Database does not exist"
    assert File.delete(file)
    refute File.exists?(file)
  end

  def test_it_can_create_a_table
    db.create_table :test do
      primary_key :id
    end
    assert db.table_exists?(:test)
  end

  def test_it_parses_csv_data
    data = {
      :id         => "1",
      :name       => "Schroeder-Jerde",
      :created_at => "2012-03-27 14:53:59 UTC",
      :updated_at => "2012-03-27 14:53:59 UTC"
    }
    assert_equal data[:id],         DB.parse_csv(file).first[:id]
    assert_equal data[:name],       DB.parse_csv(file).first[:name]
    assert_equal data[:created_at], DB.parse_csv(file).first[:created_at]
    assert_equal data[:updated_at], DB.parse_csv(file).first[:updated_at]
  end

  def test_field_names_from_schema
    db.create_table :merchants do
      primary_key :id
      String      :name
      String      :created_at
      String      :updated_at
    end
    schema = db.schema(:merchants)
    field_names = [:id, :name, :created_at, :updated_at]
    assert_equal field_names, DB.field_names_from(schema)
  end

  def test_populate_table_from_data
    db.create_table :merchants do
      primary_key :id
      String      :name
      String      :created_at
      String      :updated_at
    end
    time = Time.now.utc
    table       = :merchants
    field_names = [:id, :name, :created_at, :updated_at]
    raw_data = [
      { :id => 1, :name => "Nike", :created_at => time, :updated_at => time },
      { :id => 2, :name => "Ikea", :created_at => time, :updated_at => time },
      { :id => 3, :name => "Lift", :created_at => time, :updated_at => time }
    ]
    DB.populate_table(table, field_names, raw_data)
    assert_equal 3, db[:merchants].count
    result = db[:merchants].select(:name).where(:id => 2).to_a
    assert_equal "Ikea", result[0][:name]
  end

  def test_it_can_populate_a_table_from_a_csv
    db.create_table :merchants do
      primary_key :id
      String      :name
      String      :created_at
      String      :updated_at
    end
    DB.populate(:merchants, file)
    assert_equal 100, db[:merchants].count
  end

end
