require 'rails_helper'

RSpec.describe Exchanger do
  subject do
    Exchanger.new
  end

  describe '#get_quote' do
    context 'given an invalid string' do
      it 'returns nil when empty' do
        expect(subject.get_quote('')).to be_nil
      end

      it 'returns nil when nil' do
        expect(subject.get_quote(nil)).to be_nil
      end

      it 'returns nil when not a valid currency' do
        expect(subject.get_quote(:CAD)).to be_nil
      end
    end
    context 'given a valid currency' do
      it 'returns quotation' do
        expect(subject.get_quote(:AUD)).to be_present
        expect(subject.get_quote(:AUD)).to be_a(Hash)
        expect(subject.get_quote(:BRL)).to be_a(Hash)
        expect(subject.get_quote(:USD)).to be_a(Hash)
      end
    end

    context 'given update=false' do
      before do
        subject.quotes[:AUD] = { '2017-05-01': 1.00 }
      end
      it "doesn't update values" do
        expect(subject.get_quote(:AUD, false))
          .to include({ '2017-05-01': 1.00 })
      end
    end

    context 'given update true' do
      before do
        subject.quotes[:AUD] = { '2017-05-01': 1.00 }
      end

      it 'updates values' do
        expect(subject.get_quote(:AUD))
          .to_not include({ '2017-05-01': 1.00 })
      end
    end
  end

  describe '#get_quotes' do
    it 'returns quotes for all currencies' do
      expect(subject.get_quotes).to be_present
      expect(subject.get_quotes[:AUD]).to be_present
      expect(subject.get_quotes[:AUD]).to be_a(Hash)
      expect(subject.get_quotes[:BRL]).to be_a(Hash)
      expect(subject.get_quotes[:USD]).to be_a(Hash)
    end
  end
end
