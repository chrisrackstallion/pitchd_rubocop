# index_app fixture

A Rails-shaped tree with one deliberate offence per cross-file cop, run end to
end by `spec/rubocop_config_spec.rb` through `bundle exec rubocop
--ignore-parent-exclusion` with `rubocop-pitchd-index.yml` inherited (the
flag stops the repo's own `fixtures/**` exclusion reaching in). It proves the runner builds the index,
hands it to the department, and that each cop's `Include` reaches the file it
should — the half a unit test on a single source string cannot cover.

Offences, by cop:

| Cop | File |
|-----|------|
| `Pitchd/RouteWithoutAction` | `config/routes.rb` — `resource :closure` without `module: :cards`; `edit` routed on a controller without it |
| `Pitchd/EnqueueOutsideCommit` | `app/models/concerns/publishable.rb` — `after_save :notify_later`, the method on `Article` |
| `Pitchd/ExecutedOutsideOwnSpec` | `spec/models/article_spec.rb` — runs `NotifySubscribersJob` |
| `Pitchd/MissingOwnSpec` | `app/models/concerns/publishable.rb`, `app/policies/article_policy.rb` |
| `Pitchd/MailerWithoutPreview` | `app/mailers/user_mailer.rb` — `receipt` has no preview |
| `Pitchd/MisfiledSpec` | `spec/models/account_onboarding_spec.rb` |
| `Pitchd/UnreferencedMethod` (run with `--only`) | `app/models/article.rb` — `legacy_slug`, and nothing else |

Excluded from the repo's own lint by `.rubocop.yml` and from the gem by the
gemspec.
