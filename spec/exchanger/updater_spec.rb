require 'exchanger'
require 'rails_helper'
require 'webmock'
require 'webmock/rspec'
require 'vcr'
require_relative '../support/vcr_setup'

RSpec.describe Updater do
  subject do
    Updater.new
  end

  let!(:today) { Date.today }

  before do
    allow(Date).to receive(:today).and_return(Date
      .strptime('2017-05-23', '%Y-%m-%d'))
  end

  describe '#get_currency_data' do
    context 'given an invalid key' do
      it 'returns nil' do
        expect(subject.get_currency_data(nil)).to be_nil
        expect(subject.get_currency_data('')).to be_nil
      end
    end

    context 'got invalid data' do
      it 'returns nil' do
        # Invalid currency
        expect(subject.get_currency_data('BRS')).to be_nil
      end
    end

    context 'got valid data' do
      it 'returns a hash' do
        VCR.use_cassette('brl_quote') do
          currency_data = subject.get_currency_data(:BRL)
          expect(currency_data).to be_a(Hash)
          expect(currency_data).to_not be_empty
        end
      end
    end
  end
end
