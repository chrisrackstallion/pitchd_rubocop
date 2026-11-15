# frozen_string_literal: true

require_relative "pitchd_rubocop/version"

# Gem identity only. The cops load through `require: rubocop/pitchd` in the
# config layers, so Bundler requiring this file does not load RuboCop.
module PitchdRubocop
end
