module Currency
  CURRENCIES = [:AUD, :BRL, :USD]

  def currency_code_valid?(currency_code)
    currency_code.present? && currency_code.respond_to?(:to_sym) && CURRENCIES.include?(currency_code)
  end
end
