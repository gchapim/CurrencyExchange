require 'date'
require 'json'

# Class responsible for handling the data and filling quotes
#
# Author:: gchapim
class QuoteUpdater
  # Update local rates based on web resource
  def update(quotes)
    quotes.each_key do |key|
      hash_days = get_currency_data key
      next if hash_days.blank?

      # Cleans the hash up
      quotes[key] = {}
      hash_days.each_key do |day|
        # The first value of hash for the day is the actual rate
        quotes[key][(Date.today - (8 - day.to_i))
                    .strftime('%Y-%m-%d')] = hash_days[day].first
      end
    end
  end

  def get_currency_data(key)
    return nil if key.blank?
    api_wrapper = QuotesApiWrapper.new
    currency_data = api_wrapper.get_rates(key)
    unless currency_data.blank? || currency_data['dataSets'].blank?
      # This is the format based on web services template
      currency_data['dataSets']
        .first['series']['0:0:0:0:0']['observations']
    end
  end
end
