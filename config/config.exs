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
config :balance_sheet, BalanceSheetWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XALi0i8/vsd8H5Z2yIJl1uoBBfDKT7/kT9jOTcJpVtKPb4OcpXB3YgPm0usO/Mqo",
  render_errors: [view: BalanceSheetWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: BalanceSheet.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
