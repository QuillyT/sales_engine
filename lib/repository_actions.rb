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

  def self.define_find_methods_for(type)
    def self.define_find_by_methods_for(type)
      type.public_attributes.each do |attribute|
        define_method "find_by_#{attribute}" do |criteria|
          all.find do |object|
            object.send(attribute).to_s.downcase == criteria.to_s.downcase
          end
        end
      end
    end

    def self.define_find_all_by_methods_for(type)
      type.public_attributes.each do |attribute|
        define_method "find_all_by_#{attribute}" do |criteria|
          all.find_all do |object|
            object.send(attribute).to_s.downcase == criteria.to_s.downcase
          end
        end
      end
    end
  end


end
