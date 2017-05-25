require 'rails_helper'
require 'webmock'
require 'webmock/rspec'
require_relative '../support/vcr_setup'

RSpec.describe QuotesApiWrapper do
  subject do
    QuotesApiWrapper.new
  end

  let!(:today) { Date.today }

  before do
    allow(Date).to receive(:today).and_return(Date
      .strptime('2017-05-23', '%Y-%m-%d'))
  end

  describe '#url' do

    context 'given an invalid currency code' do
      it 'returns nil when empty' do
        expect(subject.url('')).to be_nil
      end
    end

    context 'given a valid currency code' do
      it 'returns url' do
        expect(subject.url(:AUD)).to eq('https://sdw-wsrest.ecb.europa.eu/service/data/EXR/D.AUD.EUR.SP00.A?startPeriod=2017-05-15&endPeriod=2017-05-23')
        expect(subject.url(:BRL)).to eq('https://sdw-wsrest.ecb.europa.eu/service/data/EXR/D.BRL.EUR.SP00.A?startPeriod=2017-05-15&endPeriod=2017-05-23')
        expect(subject.url(:USD)).to eq('https://sdw-wsrest.ecb.europa.eu/service/data/EXR/D.USD.EUR.SP00.A?startPeriod=2017-05-15&endPeriod=2017-05-23')
      end
    end
  end


  describe '#get_rates' do
    context 'given an invalid currency_code' do
      it 'returns nil' do
        expect(subject.get_rates(nil)).to be_nil
        expect(subject.get_rates('')).to be_nil
      end
    end

    context 'got invalid response' do
      before { VCR.turn_off! }
      after { VCR.turn_on! }
      it 'returns nil' do
        stub_request(:get, 'http://sdw-wsrest.ecb.europa.eu/service/data/EXR/D.BRL.EUR.SP00.A?endPeriod=2017-05-23&startPeriod=2017-05-15')
          .to_return(status: 404)
        expect(subject.get_rates(:BRL)).to be_nil
      end
    end

    context 'given a valid url and got sucess response' do
      it 'returns correct json' do
        json_hash = YAML.load_file('spec/support/json_hash.yml')

        VCR.use_cassette('brl_quotations') do
          returned_hash = subject.get_rates(:BRL)
          expect(returned_hash).to eq json_hash
        end
      end
    end
  end
end
