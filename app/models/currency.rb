module Currency
  CURRENCIES = {AUD: 'AUD', BRL: 'EUR', USD: 'USD'}

  def currency_code_valid?(currency_code)
    currency_code.present? && currency_code.respond_to?(:to_sym) && CURRENCIES.key?(currency_code.to_sym)
  end

  def currencies
    CURRENCIES
  end
end
