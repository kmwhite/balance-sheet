defmodule BalanceSheet do
  @moduledoc """
  Documentation for BalanceSheet.
  """

  use Application

  require BalanceSheet.Router
  require Logger

  def start(_type, _args) do
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, BalanceSheet.Router, [], [port: 8080])
    ]

    Logger.info "Started BalanceSheet"

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
