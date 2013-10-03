module RepositoryFindGenerator

  def finder_methods
    #[:find, :find_all]
    [:find_all]
  end

  def stringify_type_name(type)
    type_cypher[type]
  end

  def type_cypher
    {
      Merchant    => "merchants",
      Item        => "items",
      Customer    => "customers",
      Invoice     => "invoices",
      InvoiceItem => "invoice_items",
      Item        => "items"
    }
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

  def define_new_find_methods_for(type)
    type.public_attributes.each do |attribute|
      define_method "find_by_#{attribute}" do |criteria|
        method_name = "klass_grouped_by_#{attribute}"
          Array(send(method_name)[criteria]).first
      end
    end
  end

  def define_new_find_all_methods_for(type)
    type.public_attributes.each do |attribute|
      define_method "find_all_by_#{attribute}" do |criteria|
        method_name = "klass_grouped_by_#{attribute}"
          Array(send(method_name)[criteria])
      end
    end
  end

  def define_id_methods_for(type)
    type.public_attributes.each do |attribute|
      name = "klass_grouped_by_#{attribute}"
      define_method name do
        value = instance_variable_get("@#{name}")
        if value.nil?
          data = all.group_by { |item| item.send(attribute) }
          value = instance_variable_set("@#{name}", data)
        end
        value
      end
    end
  end

end
