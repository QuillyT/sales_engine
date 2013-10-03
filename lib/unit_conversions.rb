require 'bigdecimal'

module UnitConversions

  def convert_to_big_decimal(cents)
    BigDecimal.new(convert_cents_to_dollars(cents).to_s)
  end

  def convert_cents_to_dollars(cents)
    cents.to_i / 100.00
  end

end
