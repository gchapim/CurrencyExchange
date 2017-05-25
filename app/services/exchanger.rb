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
    CURRENCIES.each do |currency|
      @quotes[currency] = {}
    end
    @updater = QuoteUpdater.new
  end

  # Get quotes hash (a week of rates) for a currency based on Euro
  # If called before update, it will return blank hashes
  #
  # +currency_code+ symbol containing the currency code :AUD, :BRL, :USD
  def get_quote(currency_code)
    updater.update(quotes)
    quotes[currency_code] if currency_code_valid? currency_code
  end
end
