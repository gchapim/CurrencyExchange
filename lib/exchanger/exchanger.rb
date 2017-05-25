require 'exchanger'

# Class repsonsible for keeping the rates for a week for each currency from Euro
#
# Author:: gchapim
class Exchanger
  include Currency

  def initialize
    # A hash which will have another hash containing for every date we have the rate
    @quotes = {}
    CURRENCIES.each do |currency|
      @quotes[currency] = {}
    end
  end

  # Get quotes hash (a week of rates) for a currency based on Euro
  # If called before update, it will return blank hashes
  #
  # +currency_code+ symbol containing the currency code :AUD, :BRL, :USD
  def get_quote(currency_code)
    @quotes[currency_code] if currency_code_valid? currency_code
  end

  def update
    updater = Updater.new
    updater.update(@quotes)
  end
end
