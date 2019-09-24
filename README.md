# OmniAuth::Wonde

[![Gem Version](https://img.shields.io/gem/v/omniauth-wonde.svg)](https://rubygems.org/gems/omniauth-wonde)
[![Build Status](https://img.shields.io/travis/tcrouch/omniauth-wonde.svg)](https://travis-ci.org/tcrouch/omniauth-wonde)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/87b66fa1686348c38fc6936a85c63685)](https://www.codacy.com/manual/t.crouch/omniauth-wonde)

Strategy to authenticate with Wonde via OAuth2 in OmniAuth.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-wonde'
```

And then execute:

```console
$ bundle
```

Or install it yourself as:

```console
$ gem install omniauth-wonde
```

## Usage

For example, adding middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :wonde, ENV['WONDE_CLIENT_ID'], ENV['WONDE_CLIENT_SECRET']
end
```

The OmniAuth Wonde URL is then accessible at: `/auth/wonde`

### Devise

Specify as a provider in `config/initializers/devise.rb`:

```ruby
  config.omniauth :wonde, ENV['WONDE_CLIENT_ID'], ENV['WONDE_CLIENT_SECRET']
```

### Configuration

Additional configuration options can be provided as keyword arguments.

- `redirect_uri:` specify a custom redirect URI

## Auth hash

Example of authentication hash available in `request.env['omniauth.auth']`:

```ruby
{
  "provider" => "wonde",
  "uid" => "A1000000000",
  "info" => {
    "name" => "John Schmidt",
    "first_name" => "John",
    "last_name" => "Schmidt",
    "middle_names" => "Jacob Jingleheimer",
    "school_name" => "Acorn Primary School",
    "school_id" => "A1000000001",
    "person_type" => "student",
    "person_id" => "A100000002",
    "upi" => "0d50e37c226a4c189404f2d0747f5839"
  },
  "credentials" => {
    "token" => "[TOKEN]",
    "refresh_token" => "[REFRESH_TOKEN]",
    "expires_at" => 1496120719,
    "expires" => true
  },
  "extra" => {
    "raw_info" => {
      "Me" => {
        "id" => "A1000000000",
        "Person" => {
          "id" => "A100000002",
          "type" => "student",
          "forename" => "John",
          "middle_names" => "Jacob Jingleheimer",
          "surname" => "Schmidt",
          "upi" => "0d50e37c226a4c189404f2d0747f5839",
          "School" => {
            "id" => "A1000000001",
            "name" => "Acorn Primary School"
          }
        }
      }
    }
  }
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tcrouch/omniauth-wonde.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
