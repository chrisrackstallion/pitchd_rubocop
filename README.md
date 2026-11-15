# pitchd_rubocop

RuboCop cops and config layers for Pitch'd's Rails conventions: no service
objects, REST-only controller actions, enqueueing after commit, no view specs,
no `sleep` in specs, and the rest of what a parser can settle. The cops live in
the `Pitchd/` department, and each offence states the problem and the fix, so
it can be acted on from the message alone. Four config layers, in increasing
strictness, let an app choose how much of it to take.

## Installation

```ruby
# Gemfile
gem "pitchd_rubocop", require: false
```

```yaml
# .rubocop.yml
inherit_gem:
  rubocop-rails-omakase: rubocop.yml
  pitchd_rubocop:
    - rubocop.yml                # thin layer over omakase — changes almost nothing
    - rubocop-pitchd.yml         # opt-in: the Pitchd cops and the existing cops that encode the conventions
    - rubocop-pitchd-rspec.yml   # opt-in: needs rubocop-rspec and friends in your Gemfile
    - rubocop-pitchd-index.yml   # opt-in: cross-file cops; needs RuboCop 1.89 and the rubydex gem
```

Order matters: each layer builds on the one above it, and omakase stays the
source of truth for formatting. Your own `.rubocop.yml` wins over all of them,
so any cop can be turned off there with the reason beside it.

## The layers

**`rubocop.yml`** is a thin layer over omakase that restates and contradicts
none of its cop settings. It does not set `NewCops`, so whether new cops are
pending or enabled stays your app's call and your lint results do not change
when your RuboCop version bumps.

**`rubocop-pitchd.yml`** turns on about 100 existing cops that encode
conventions already settled, plus the custom `Pitchd/*` cops for what no
existing cop covers — service objects, non-REST actions,
enqueueing inside transactions, view specs, `sleep` in specs. It is opt-in
because omakase deliberately does not lint semantics, and turning these on is a
change of position an app should choose rather than inherit on a gem bump. It
needs `rubocop-rails >= 2.29`. RuboCop parses Ruby only, so Hotwire,
JavaScript, Tailwind, and ERB conventions get no coverage here.

**`rubocop-pitchd-rspec.yml`** is the spec half: naming, shape, and the
FactoryBot, Capybara, and RSpec Rails conventions the existing spec cops
already cover. It needs these in your own Gemfile; this gem depends only on
RuboCop at runtime and will not pull them in for you:

```ruby
gem "rubocop-rspec", require: false
gem "rubocop-rspec_rails", require: false
gem "rubocop-capybara", require: false
gem "rubocop-factory_bot", require: false
```

**`rubocop-pitchd-index.yml`** turns on RuboCop's project index and the cops
that need one, because they span files: a route naming an action no controller
defines, a callback enqueueing through a concern's method, a spec running a job
it does not own, a concern or policy with no spec, a mail with no preview. It
needs RuboCop >= 1.89 and `gem "rubydex", require: false` in your Gemfile;
without the gem RuboCop warns and the layer stays silent rather than breaking
the run. The department still loads on an older RuboCop; the cross-file
helpers then stay silent rather than aborting.

## Finding dead methods

The index layer also carries a dead-method sweep, `Pitchd/UnreferencedMethod`,
that is never enabled: it is blind to dispatch assembled from strings, so as a
gate it would cry wolf. Run it by name when you want it — `--only` runs a cop
whether or not config enables it:

```bash
bin/rubocop --only Lint/UnusedPrivateMethod,Pitchd/UnreferencedMethod
```

It counts symbols in every indexed file and identifiers in every view template
as uses, and exempts the names Rails calls by convention.

## License

MIT. See `LICENSE`.
