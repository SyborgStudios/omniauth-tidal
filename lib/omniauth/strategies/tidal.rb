require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Tidal < OmniAuth::Strategies::OAuth2
      option :name, 'tidal'

      option :client_options,
             site: 'https://auth.tidal.com',
             authorize_url: 'https://login.tidal.com/authorize',
             token_url: 'https://auth.tidal.com/v1/oauth2/token'

      option :pkce, true

      uid{ raw_info.data.id }

      info do
        {
          email: raw_info.data.attributes.email,
          username: raw_info.data.attributes.username,
          country: raw_info.data.attributes.country,
          email_verified: raw_info.data.attributes.email_verified
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('https://openapi.tidal.com/v2/users/me').parsed
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
