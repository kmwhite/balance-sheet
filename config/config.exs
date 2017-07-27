# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :balance_sheet,
  ecto_repos: [BalanceSheet.Repo]

# Configures the endpoint
config :balance_sheet, BalanceSheet.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Lho220FpEj3s/Fbr9ajtYifV4+rj3lzCZPXa7IOENpFjc41bY8JrC0nARatOp5NQ",
  render_errors: [view: BalanceSheet.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BalanceSheet.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
