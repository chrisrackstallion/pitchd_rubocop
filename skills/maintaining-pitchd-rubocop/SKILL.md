---
name: maintaining-pitchd-rubocop
description: >-
  Change the pitchd_rubocop gem itself — the Pitchd cops, their defaults, the
  config layers, and packaging. Use when adding or changing a cop or editing
  anything in this repository. Not for clearing offences in an app.
---

# Maintaining pitchd_rubocop

**Announce:** "I'm using the maintaining-pitchd-rubocop skill."

Not shipped: the gemspec ships `lib/`, `config/`, the `rubocop*.yml` layers,
and the top-level docs, and `spec/gem_spec.rb` asserts `skills/` stays out.

## A new cop touches three places

1. The cop, under `lib/rubocop/cop/pitchd/`.
2. Its defaults in `config/default.yml`: `Description`, `Enabled`,
   `VersionAdded`, and `Include` scoping it by path rather than in Ruby. An
   ordinary cop is enabled there, and `rubocop-pitchd.yml` turns it on simply
   by requiring the department. A cross-file cop instead gets
   `Enabled: false` there and an `Enabled: true` entry in
   `rubocop-pitchd-index.yml`, so it runs only where the project index does.
3. Coverage in `spec/cops/`, in the file for its area.

**The message is the documentation.** It states the problem and the fix, so an
agent can act on the offence alone. This gem knows nothing about the apps
that use it: no link or path to prose that explains a convention, in a message
or in `config/default.yml`.

## What holds the rest

| Concern | Gate |
|---|---|
| A layer names a cop that no longer exists upstream | `spec/rubocop_config_spec.rb` |
| A cop has no default or `Include` | `spec/rubocop_config_spec.rb` |
| The index layer works through the real runner | `fixtures/index_app`, run by the same spec |
| A file must ship, or must not | `spec/gem_spec.rb` |

`rubocop.yml` stays free of cop settings: it is the thin layer over omakase,
and enforcement belongs in the opt-in layers.

## Verify

```bash
bundle exec rake
```

Specs then RuboCop, both clean. A consumer-facing change gets a line in
`CHANGELOG.md` under `## [Unreleased]`; `lib/pitchd_rubocop/version.rb` moves
at release time.
