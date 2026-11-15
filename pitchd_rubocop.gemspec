# frozen_string_literal: true

require_relative "lib/pitchd_rubocop/version"

Gem::Specification.new do |spec|
  spec.name = "pitchd_rubocop"
  spec.version = PitchdRubocop::VERSION
  spec.authors = [ "Chris Bellairs" ]
  spec.email = [ "chris@pitchd.ai" ]

  spec.summary = "RuboCop cops and config layers for Pitch'd's Rails conventions."
  spec.description = <<~TEXT.gsub("\n", " ").strip
    The Pitchd cop department and the opt-in config layers that enable it:
    Rails conventions a parser can settle, each offence stating the problem
    and the fix.
  TEXT

  spec.homepage = "https://github.com/chrisrackstallion/pitchd_rubocop"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.3"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # config/default.yml is loaded by path when the department is required, and
  # the rubocop*.yml layers are what an app names in inherit_gem.
  spec.files = Dir.chdir(__dir__) do
    Dir.glob("lib/**/*.rb") + Dir.glob("config/*.yml") + Dir.glob("rubocop*.yml") +
      [ "LICENSE", "README.md", "CHANGELOG.md" ].select { |f| File.exist?(f) }
  end

  spec.require_paths = [ "lib" ]

  # 1.72 is the first RuboCop with the `plugins:` key the layers use.
  spec.add_dependency "rubocop", ">= 1.72"
end
