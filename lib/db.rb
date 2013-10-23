require 'sequel'
require 'sqlite3'
require 'csv'
require 'pry'

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

  def self.destroy
    @database = nil
    file = "#{dir}/sales_engine.sqlite3"
    File.delete(file) if File.exists?(file)
  end

  def self.populate(table, file)
    raw_data    = parse_csv(file)
    field_names = field_names_from(database.schema(table))
    populate_table(table, field_names, raw_data)
  end

  def self.populate_table(table, field_names, raw_data)
    raw_data.each do |row|
      data = build_row_data_from(field_names, row)
      database[table].insert(data)
    end
  end

  def self.build_row_data_from(field_names, row)
   field_names.each_with_object({}) do |name, hash|
      hash[name] = row[name] unless name == :id
    end
  end

  def self.field_names_from(schema)
    schema.map { |field| field[0] }
  end

  def self.parse_csv(file)
    CSV.read file, headers: true, header_converters: :symbol
  end

end
