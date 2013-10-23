require './test/test_helper'
require './lib/db'

class DBTest < Minitest::Test
  def test_it_exists
    assert DB
  end

  def test_it_iniitializes_with_a_directory
    dir = './test/db'
    db = DB.new(dir)
    assert_equal dir, db.dir
  end

  def test_it_creates_a_new_db
    file = './test/db/sales_engine.sqlite3'
    refute File.exists?(file)

    db = DB.new('./test/db').database
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

end
