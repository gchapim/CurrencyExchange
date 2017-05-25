require 'exchanger'

# Class repsonsible for keeping the rates for a week for each currency from Euro
#
# Author:: gchapim
class Exchanger
  include Currency

  attr_accessor :quotes, :updater

  def initialize
    # A hash which will have another hash containing for every date we have the rate
    @quotes = {}
    CURRENCIES.each_key do |currency|
      @quotes[currency] = {}
    end
    @updater = QuoteUpdater.new
  end

  # Get quotes hash (a week of rates) for a currency based on Euro
  # If called before update, it will return blank hashes
  #
  # +currency_code+ symbol containing the currency code :AUD, :BRL, :USD
  # +update+ if the exchanger needs to update its values before returning quotes
  def get_quote(currency_code, update=true)
    updater.update(quotes) if update

    if currency_code_valid?(currency_code)
      currency_code = currency_code.to_sym
      quotes[currency_code]
    end
  end

  def get_quotes(update=true)
    quotes.each_key do |key|
      quotes[key] = get_quote(key, update)
    end
  end
end
