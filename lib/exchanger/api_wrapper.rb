require 'uri'
require 'net/http'
require 'json'
require 'exchanger/currency'

# Class responsible for communicating with external resources and get json
#
# Author:: gchapim
class ApiWrapper
  include Currency

  def get_rates(currency_code)
    url = url currency_code
    return nil if url.blank?

    response = get_response_from_url url
    json_from_response(response)
  end

  def url(currency_code)
    return nil unless currency_code_valid?(currency_code)
    start_date = (Date.today - 8).strftime('%Y-%m-%d')
    end_date = Date.today.strftime('%Y-%m-%d')
    "https://sdw-wsrest.ecb.europa.eu/service/data/EXR/D.#{currency_code}.EUR.SP00.A?startPeriod=#{start_date}&endPeriod=#{end_date}" unless currency_code.blank?
  end
 
  private

  def json_from_response(response)
    JSON.parse(response.body) unless response.blank? || response.body.blank?
  end

  def get_response_from_url(url)
    uri = URI(url)
    request = Net::HTTP::Get.new(uri)
    request.add_field('Accept',
                      'application/vnd.sdmx.data+json;version=1.0.0-wd')
    response = Net::HTTP.new(uri.host).start do |http|
      http.request(request)
    end
    response if !response.blank? && response.code == ('200' || '201')
  end
end
