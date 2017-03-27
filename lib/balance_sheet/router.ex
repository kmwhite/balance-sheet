defmodule BalanceSheet.Router do
  @moduledoc """
    BalanceSheet.Router
  """

  # FIXME: Remove "Response has already been sent" error
  # There is a problem in this code. We need to figure out why the code
  # breaks when we send it a graphql request. The response is an error
  # about the syntax around query, but the app has an error about the
  # response already being sent. There may be nothing linking the two
  # problems

  use Plug.Router

  require Absinthe
  require BalanceSheet.Schema
  require Logger

  plug Plug.RequestId              # Set up per-request ID to use in Logs
  plug Plug.Logger, log: :debug    # Log Requests
  plug Plug.Parsers,               # Parsers for each Content-Type
    json_decoder: Poison,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser]

  plug :match
  plug :dispatch

  forward "/gql", to: Absinthe.Plug, schema: BalanceSheet.Schema

  if Mix.env == :dev do
    forward "/graphiql", to: Absinthe.Plug.GraphiQL, schema: BalanceSheet.Schema
  end

  match _ do
    Logger.info('Catch all triggered. Returning 404')

    conn
    |> send_resp(404, "Oops!")
    |> halt
  end
end
