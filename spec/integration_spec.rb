require 'spec_helper'

describe 'Integration test' do
  it 'loads the gem successfully' do
    expect(OmniAuth::Strategies::Tidal).to be_a(Class)
  end

  it 'can instantiate the strategy with client id and secret' do
    strategy = OmniAuth::Strategies::Tidal.new(nil, 'client_id', 'client_secret')
    expect(strategy).to be_a(OmniAuth::Strategies::Tidal)
  end

  it 'has correct OAuth2 client options' do
    strategy = OmniAuth::Strategies::Tidal.new(nil, 'client_id', 'client_secret')
    
    expect(strategy.options.client_options.site).to eq('https://auth.tidal.com')
    expect(strategy.options.client_options.authorize_url).to eq('https://login.tidal.com/authorize')
    expect(strategy.options.client_options.token_url).to eq('https://auth.tidal.com/v1/oauth2/token')
  end
end
