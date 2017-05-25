require 'date'
require 'json'

# Class responsible for handling the data and filling quotes
#
# Author:: gchapim
class QuoteUpdater

  attr_accessor :dates

  def initialize
    @dates = []
  end

  # Update local rates based on web resource
  def update(quotes)
    quotes.each_key do |key|
      hash_days = get_currency_data key
      next if hash_days.blank?

      # Cleans the hash up
      quotes[key] = {}
      hash_days.each_key do |day|
        # The first value of hash for the day is the actual rate
        quotes[key][@dates[day.to_i]] = hash_days[day].first
      end
    end
  end

  def get_currency_data(key)
    return nil if key.blank?
    api_wrapper = QuotesApiWrapper.new
    currency_data = api_wrapper.get_rates(key)
    unless currency_data.blank? || currency_data['dataSets'].blank?
      # This is the format based on web services template
      fill_dates(currency_data)
      currency_data['dataSets']
        .first['series']['0:0:0:0:0']['observations']
    end
  end

  private

  def fill_dates(currency_data)
    @dates = []
    currency_data['structure']['dimensions']['observation']
        .first['values'].each do |value|
          @dates << value['id']
    end
  end
end
