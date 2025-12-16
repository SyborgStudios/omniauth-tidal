require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Tidal < OmniAuth::Strategies::OAuth2
      option :name, 'tidal'

      option :client_options,
             site: 'https://auth.tidal.com',
             authorize_url: 'https://login.tidal.com/authorize',
             token_url: 'https://auth.tidal.com/v1/oauth2/token'

      uid { raw_info['userId'] }

      info do
        {
          email: raw_info['email'],
          name: raw_info['username'],
          first_name: raw_info['firstName'],
          last_name: raw_info['lastName']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('https://api.tidal.com/v1/users/me').parsed
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
