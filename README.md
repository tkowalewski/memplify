# memplify

Memplify is a custom reporter ([memplify.com](https://memplify.com)) for [memory_profiler](https://rubygems.org/gems/memory_profiler) gem.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add memplify
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install memplify
```

## Usage

### Rails applications

Create initializer for memplify:

```ruby
# config/initializers/memplify.rb
require "memplify"

Memplify.configure do |configuration|
  configuration.access_token = "[ACCESS_TOKEN]"
end
```

For example add memplify middleware for staging environment:

```ruby
# config/environments/staging.rb
Rails.application.configure do
  config.middleware.insert(0, Memplify::Middleware)
end
```

### Rack applications

```ruby
# config.ru
require "memplify"

Memplify.configure do |configuration|
  configuration.access_token = "[ACCESS_TOKEN]"
end

class Application
  def call(env)
    status  = 200
    headers = { "content-type" => "text/html" }
    body    = ["Kaboom!"]

    [status, headers, body]
  end
end

builder = Rack::Builder.new do
  use Memplify::Middleware if ENV["RACK_ENV"] == "staging"

  map('/') { run Application.new }
end

run builder
```

### Other applications / services

You can use memplify also in background jobs and in any place of your app by using reporter directly.
Just provide report identifier and wrap code with:

```ruby
Memplify.report("custom/profile", profile: ENV["ENVIRONMENT"] == "staging") do
  # Your code
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tkowalewski/memplify. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/memplify/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Memplify project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/memplify/blob/main/CODE_OF_CONDUCT.md).
