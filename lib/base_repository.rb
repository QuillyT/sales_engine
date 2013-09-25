require 'csv'

class BaseRepository

  attr_reader :filename

  def initialize(filename=nil)
    @type = nil
    load(filename)
  end

  def load(filename)
    filename ||= default_filename
    @instance_hashes = CSV.read filename, headers: true, header_converters: :symbol
  end

  def default_filename
    nil
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

  def random
    all.sample
  end
end
