module Currency
  CURRENCIES = [:AUD, :BRL, :USD]

  def currency_code_valid?(currency_code)
    currency_code.present? && currency_code.is_a?(Symbol) && CURRENCIES.include?(currency_code)
  end
end
