# frozen_string_literal: true

require "rspec/core/rake_task"
require "rubocop/rake_task"

RSpec::Core::RakeTask.new(:spec)

# While this gem is nested in another repository, RuboCop also applies the
# outer .rubocop.yml's AllCops/Exclude, which excludes this whole directory.
# Without the flag RuboCop inspects 0 files and still reports success.
RuboCop::RakeTask.new do |task|
  task.options = [ "--ignore-parent-exclusion" ]
end

task default: [ :spec, :rubocop ]
