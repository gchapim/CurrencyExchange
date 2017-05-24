module Currency
  CURRENCIES = [:AUD, :BRL, :USD]

  def currency_code_valid?(currency_code)
    if currency_code.blank? || !currency_code.is_a?(Symbol) ||
       !CURRENCIES.include?(currency_code)

      false
    else
      true
    end
  end
end
