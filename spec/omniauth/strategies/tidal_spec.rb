require 'spec_helper'

describe OmniAuth::Strategies::Tidal do
  subject { described_class.new(nil) }

  describe 'client options' do
    it 'has correct name' do
      expect(subject.options.name).to eq('tidal')
    end

    it 'has correct site' do
      expect(subject.options.client_options.site).to eq('https://auth.tidal.com')
    end

    it 'has correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('https://login.tidal.com/authorize')
    end

    it 'has correct token url' do
      expect(subject.options.client_options.token_url).to eq('https://auth.tidal.com/v1/oauth2/token')
    end
  end

  describe '#uid' do
    before do
      allow(subject).to receive(:raw_info).and_return({ 'userId' => '12345' })
    end

    it 'returns the user id from raw_info' do
      expect(subject.uid).to eq('12345')
    end
  end

  describe '#info' do
    before do
      allow(subject).to receive(:raw_info).and_return({
        'email' => 'test@example.com',
        'username' => 'testuser',
        'firstName' => 'Test',
        'lastName' => 'User'
      })
    end

    it 'returns the user info' do
      expect(subject.info).to eq({
        email: 'test@example.com',
        name: 'testuser',
        first_name: 'Test',
        last_name: 'User'
      })
    end
  end

  describe '#extra' do
    before do
      allow(subject).to receive(:raw_info).and_return({ 'userId' => '12345' })
    end

    it 'returns extra info' do
      expect(subject.extra).to eq({ 'raw_info' => { 'userId' => '12345' } })
    end
  end
end
