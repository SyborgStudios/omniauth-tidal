# OmniAuth Tidal

This gem provides a simple way to authenticate to the Tidal API using OmniAuth with OAuth2. It supports PKCE (Proof Key for Code Exchange) for enhanced security and uses Tidal's OpenAPI v2 endpoints.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-tidal'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install omniauth-tidal
```

## Usage

### Rails Application

Add the Tidal strategy to your OmniAuth middleware. In `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :tidal, ENV['TIDAL_CLIENT_ID'], ENV['TIDAL_CLIENT_SECRET'], scope: 'user.read ...' 
end
```

### Rack Application

```ruby
use OmniAuth::Builder do
  provider :tidal, ENV['TIDAL_CLIENT_ID'], ENV['TIDAL_CLIENT_SECRET'], scope: 'user.read ...' 
end
```

## Configuration

You'll need to register your application with Tidal to get a client ID and client secret. Visit the [Tidal Developer Portal](https://developer.tidal.com/) to create an application.

**Important:** Make sure to add your callback URL to your Tidal application settings. The default callback URL is:
```
http://localhost:3000/auth/tidal/callback
```

### Required Scopes

This gem requires the following OAuth scopes:
- `user.read` - Access to user profile information

You can request additional scopes as needed:
- `playback` - Control playback
- `search.read` - Search for music content

### Additional Options

You can pass additional options to customize the strategy:

```ruby
provider :tidal, ENV['TIDAL_CLIENT_ID'], ENV['TIDAL_CLIENT_SECRET'],
  scope: 'user.read playback search.read',
  callback_path: '/auth/tidal/callback'
```

**Note:** PKCE is enabled by default for enhanced security, as required by Tidal's OAuth2 implementation.

## Authentication Hash

After successful authentication, you'll receive an authentication hash with the following structure:

```ruby
{
  provider: 'tidal',
  uid: '206794742',
  info: {
    email: 'user@example.com',
    username: 'johndoe',
    country: 'US',
    email_verified: true
  },
  credentials: {
    token: 'ACCESS_TOKEN',
    refresh_token: 'REFRESH_TOKEN',
    expires_at: 1234567890,
    expires: true
  },
  extra: {
    raw_info: {
      data: {
        id: '206794742',
        type: 'users',
        attributes: {
          username: 'johndoe',
          email: 'user@example.com',
          email_verified: true,
          country: 'US'
        }
      }
    }
  }
}
```

### API Endpoints Used

This gem uses the following Tidal API endpoints:
- **Authorization**: `https://login.tidal.com/authorize`
- **Token Exchange**: `https://auth.tidal.com/v1/oauth2/token`
- **User Info**: `https://openapi.tidal.com/v2/users/me`

## Example Rails Controller

```ruby
class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    user = User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
      u.email = auth['info']['email']
      u.username = auth['info']['username']
      u.country = auth['info']['country']
    end
    session[:user_id] = user.id
    redirect_to root_path, notice: 'Signed in with Tidal successfully'
  end

  def failure
    redirect_to root_path, alert: 'Authentication failed'
  end
end
```

Add routes in `config/routes.rb`:

```ruby
get '/auth/:provider/callback', to: 'sessions#create'
get '/auth/failure', to: 'sessions#failure'
```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SyborgStudios/omniauth-tidal.

## License

The gem is available as open source under the terms of the [MIT License](LICENSE).
