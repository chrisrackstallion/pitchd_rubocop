# frozen_string_literal: true

require "rubocop"
require "pathname"

module RuboCop
  # Custom cops for Rails conventions no existing cop covers. Loaded only when
  # an app inherits rubocop-pitchd.yml, which requires this file.
  module Pitchd
    PROJECT_ROOT = Pathname.new(__dir__).parent.parent.expand_path.freeze
    CONFIG_DEFAULT = PROJECT_ROOT.join("config", "default.yml").freeze
  end
end

# Takes the config file itself; passing a project root has not been supported
# since RuboCop 1.76.
RuboCop::ConfigLoader.inject_defaults!(RuboCop::Pitchd::CONFIG_DEFAULT)

# Shared mixins first; the cops are loaded in name order and several include
# these. IndexHelp optionally includes RuboCop's ProjectIndexHelp (1.89+);
# without it the department still loads and those cops stay silent.
require_relative "pitchd/public_methods"
require_relative "pitchd/index_help"

# Which paths each cop applies to is config, not code: every cop's Include lives
# in config/default.yml, so an app can widen or narrow it without a patch.
Dir[File.join(__dir__, "cop", "pitchd", "*.rb")].sort.each { |cop| require cop }
