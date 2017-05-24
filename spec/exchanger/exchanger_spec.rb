require 'exchanger'
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

      it 'returns nil when not a symbol' do
        expect(subject.get_quote('BRL')).to be_nil
      end

      it 'returns nil when not a valid currency' do
        expect(subject.get_quote(:CAD)).to be_nil
      end
    end
    context 'given a valid currency' do
      it 'returns quotation' do
        expect(subject.get_quote(:AUD)).to be_empty
        expect(subject.get_quote(:AUD)).to be_a(Hash)
        expect(subject.get_quote(:BRL)).to be_empty
        expect(subject.get_quote(:BRL)).to be_a(Hash)
        expect(subject.get_quote(:USD)).to be_empty
        expect(subject.get_quote(:USD)).to be_a(Hash)
      end
    end
  end
end
