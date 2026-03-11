# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
mix setup              # Install deps and create/migrate/seed the database
mix phx.server         # Start the dev server at localhost:4000
iex -S mix phx.server  # Start server in interactive IEx shell
mix test               # Run all tests (auto-creates and migrates test DB)
mix test test/path/to/my_test.exs  # Run a single test file
mix test --failed      # Re-run only previously failed tests
mix precommit          # Full pre-commit check: compile (warnings as errors), remove unused deps, format, test
mix ecto.reset         # Drop and recreate the database
```

## Architecture

This is a Phoenix 1.8 JSON API application backed by MySQL (via `myxql`/Ecto). There are no HTML views or LiveView routes yet — the router only exposes a `/api` scope with a JSON pipeline.

- `lib/import_error/` — business logic, Ecto schemas, context modules
- `lib/import_error_web/` — Phoenix web layer (router, controllers, endpoint)
- `lib/import_error_web.ex` — defines `use ImportErrorWeb, :controller` etc. macros
- `ImportError.Repo` — MySQL-backed Ecto repo
- Database: `import_error_dev` (dev), `import_error_test` (test), credentials: root with no password on localhost

## Key Guidelines

### Workflow
- Run `mix precommit` when done with all changes to catch issues before committing.
- Use `Req` for HTTP requests — it's the preferred client. Never use `:httpoison`, `:tesla`, or `:httpc`.

### Phoenix v1.8
- LiveView templates must begin with `<Layouts.app flash={@flash} ...>`.
- `<.flash_group>` is only allowed inside `layouts.ex`.
- Use `<.icon name="hero-x-mark">` for icons, never `Heroicons` modules.
- Use `<.input>` from `core_components.ex` for form inputs.
- Router `scope` blocks provide an alias — never add a redundant `alias` inside a scope.
- `Phoenix.View` is removed; don't use it.

### Elixir
- Lists don't support index access (`list[i]`); use `Enum.at/2` or pattern matching.
- `if`/`case`/`cond` results must be bound outside the expression — rebinding inside the block has no effect on the outer scope.
- Never nest multiple modules in the same file.
- Never use map access syntax (`changeset[:field]`) on structs; use `struct.field` or `Ecto.Changeset.get_field/2`.
- Predicate functions end with `?`, not `is_` prefix (reserve `is_` for guards).
- Don't call `String.to_atom/1` on user input.

### Ecto
- Always preload associations before accessing them in templates.
- Schema fields use `:string` type even for text columns.
- `validate_number/2` does not support `:allow_nil`.
- Use `Ecto.Changeset.get_field/2` to read changeset fields.
- Don't `cast` fields that are set programmatically (e.g. `user_id`); set them explicitly instead.
- `import Ecto.Query` in `seeds.exs`.