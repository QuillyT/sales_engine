module RepositoryFindGenerator

  def finder_methods
    [:find, :find_all]
  end

  def define_find_methods_for(type)
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
