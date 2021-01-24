# Requiring script files that are used by other scripts in tests:
Code.require_file("support/accounts_helpers.exs",__DIR__)
Code.require_file("support/fixtures/accounts_fixtures.exs", __DIR__)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(ReservationBook.Repo, :manual)
