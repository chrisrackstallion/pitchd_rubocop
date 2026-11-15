# frozen_string_literal: true

require "spec_helper"

RSpec.describe "gem packaging" do
  let(:root) { File.expand_path("..", __dir__) }
  let(:spec) { Gem::Specification.load(File.join(root, "pitchd_rubocop.gemspec")) }

  it "matches its require to its name" do
    expect(spec.files).to include("lib/#{spec.name}.rb")
    expect(spec.executables).to be_empty
  end

  it "ships neither specs, fixtures, nor the skill that develops this gem" do
    expect(spec.files.grep(%r{\A(spec|fixtures|skills)/})).to be_empty
  end

  it "ships every library file and the config that describes the cops" do
    # RuboCop loads config/default.yml by path when the department is required,
    # so leaving it out breaks cop loading in a consuming app and nowhere else.
    expect(spec.files).to include("config/default.yml", *Dir.glob("lib/**/*.rb", base: root))
  end

  it "ships every config layer so apps can inherit_gem them" do
    expect(spec.files).to include(*Dir.glob("rubocop*.yml", base: root))
  end

  it "depends on RuboCop and nothing else at runtime" do
    # The plugins and rubydex belong to whichever layer an app inherits.
    expect(spec.runtime_dependencies.map(&:name)).to eq([ "rubocop" ])
  end

  it "lints against the Ruby floor the gemspec declares" do
    floor = spec.required_ruby_version.requirements.first.last
    target = YAML.safe_load_file(File.join(root, ".rubocop.yml")).dig("AllCops", "TargetRubyVersion")

    expect(target.to_s).to eq(floor.segments.first(2).join("."))
  end
end
