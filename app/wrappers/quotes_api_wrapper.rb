require 'uri'
require 'net/http'
require 'json'

# Class responsible for communicating with external resources and get json
#
# Author:: gchapim
class QuotesApiWrapper
  include Currency

  def get_rates(currency_code)
    response = get_response_from_url(currency_code)
    json_from_response(response)
  end

  def url(currency_code)
    return nil unless currency_code_valid?(currency_code)
    currency_code = currency_code.to_sym
    start_date = (Date.today - 8).strftime('%Y-%m-%d')
    end_date = Date.today.strftime('%Y-%m-%d')
    "https://sdw-wsrest.ecb.europa.eu/service/data/EXR/D.#{currency_code}.EUR.SP00.A?startPeriod=#{start_date}&endPeriod=#{end_date}" unless currency_code.blank?
  end

  private

  def json_from_response(response)
    JSON.parse(response.body) unless response.blank? || response.body.blank?
  end

  def get_response_from_url(currency_code)
    url = url(currency_code)
    return nil if url.blank?

    uri = URI(url)
    request = Net::HTTP::Get.new(uri)
    request.add_field('Accept',
                      'application/vnd.sdmx.data+json;version=1.0.0-wd')
    response = Net::HTTP.new(uri.host).start.request(request)

    response if ['200', '201'].include?(response.code)
  end
end
