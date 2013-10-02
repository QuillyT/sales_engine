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

  def self.finder_methods
    [:find, :find_all]
  end

  def self.define_find_methods_for(type)
    type.public_attributes.each do |attribute|
      finder_methods.each do |finder|
        define_method "#{finder}_by_#{attribute}" do |criteria|
          all.send(finder) do |object|
            object.send(attribute).to_s.downcase == criteria.to_s.downcase
          end
        end
      end
    end
  end

end
