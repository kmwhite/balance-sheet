use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :balance_sheet, BalanceSheet.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :balance_sheet, BalanceSheet.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "balance_sheet",
  password: "password",
  database: "balance_sheet_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
