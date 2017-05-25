class HomeController < ApplicationController
  def index
    exchanger = Exchanger.new
    @quotes = exchanger.get_quotes

    @quotes.each do |key, value|
      if value.empty?
        @messages ||= {}
        (@messages[:errors] ||=[]) << ["Error: Couldn't get quotes data from API for currency #{key.to_s}."]
      end
    end
  end
end
