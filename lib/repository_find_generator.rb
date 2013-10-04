module RepositoryFindGenerator

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

  def define_new_find_methods_for(klass)
    klass.public_attributes.each do |attribute|
      define_method "find_by_#{attribute}" do |criteria|
        method_name = "klass_grouped_by_#{attribute}"
        Array(send(method_name)[criteria]).first
      end
    end
  end

  def define_new_find_all_methods_for(klass)
    klass.public_attributes.each do |attribute|
      define_method "find_all_by_#{attribute}" do |criteria|
        method_name = "klass_grouped_by_#{attribute}"
        Array(send(method_name)[criteria])
      end
    end
  end

  def define_id_methods_for(klass)
    klass.public_attributes.each do |attribute|
      name = "klass_grouped_by_#{attribute}"
      define_method name do
        if instance_variable_get("@#{name}").nil?
          data  = all.group_by { |item| item.send(attribute) }
          instance_variable_set("@#{name}", data)
        end
        instance_variable_get("@#{name}")
      end
    end
  end

end
