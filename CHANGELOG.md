# Changelog

All notable changes to this project are documented in this file. The format is
based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [0.1.0] - 2026-11-15

### Added

- **The `Pitchd/` cop department** — 26 cops for Rails conventions no existing
  cop covers: service objects, non-REST controller actions, enqueueing inside a
  transaction, view specs, `sleep` in specs, policy and mailer shape, and the
  cross-file checks that need RuboCop's project index. Each offence states the
  problem and the fix. Defaults and path scoping live in `config/default.yml`.
- **Four config layers** for `inherit_gem`, in increasing strictness:
  `rubocop.yml` (a thin layer over omakase), `rubocop-pitchd.yml` (the Pitchd
  cops plus the existing cops that encode the same conventions; needs
  `rubocop-rails >= 2.29`), `rubocop-pitchd-rspec.yml` (needs `rubocop-rspec`,
  `rubocop-rspec_rails`, `rubocop-capybara`, and `rubocop-factory_bot`), and
  `rubocop-pitchd-index.yml` (needs RuboCop >= 1.89 and `rubydex`).
