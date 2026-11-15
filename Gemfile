# frozen_string_literal: true

source "https://rubygems.org"

gemspec

gem "rake", require: false
gem "rspec", "~> 3.13"
gem "rubocop-rails-omakase", require: false

# Not used to lint this repo. They let spec/rubocop_config_spec.rb assert that
# every cop the rspec layer names resolves; a consuming app supplies its own.
gem "rubocop-capybara", "~> 3.0", require: false
gem "rubocop-factory_bot", "~> 2.28", require: false
gem "rubocop-rspec", "~> 3.10", require: false
gem "rubocop-rspec_rails", "~> 2.32", require: false

# The optional project index behind rubocop-pitchd-index.yml. A consuming app
# adds it to its own Gemfile; here it lets the cross-file cops run on fixtures.
gem "rubydex", require: false
