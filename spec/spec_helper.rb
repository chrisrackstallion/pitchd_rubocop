# frozen_string_literal: true

require "fileutils"
require "tmpdir"
require "json"
require "yaml"
require "rubocop"
require "rubocop/rspec/support"

require_relative "../lib/pitchd_rubocop"

module ProjectHelpers
  def project = @project
end

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :expect }
  config.disable_monkey_patching!
  config.order = :random
  config.include ProjectHelpers

  # Every example gets an empty project directory to write an app into.
  config.around do |example|
    Dir.mktmpdir("pitchd-rubocop-spec") do |dir|
      @project = dir
      example.run
    end
  end
end
