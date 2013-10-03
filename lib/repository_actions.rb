module RepositoryActions

  def load(filename)
    @instance_hashes = CSV.read filename, headers: true,
                                header_converters: :symbol
  end

  def all
    @instances ||= create_instances
  end

  def create_instances
    @instance_hashes.collect { |data| type.new(data, self) }
  end

  def random
    all.sample
  end

  def time_now
    Time.now.utc
  end

  def nuke_groups
    type.public_attributes.each do |attribute|
      name = "klass_grouped_by_#{attribute}"
      instance_variable_set("@#{name}", {})
    end
  end

end
