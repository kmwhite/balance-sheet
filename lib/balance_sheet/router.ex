defmodule BalanceSheet.Router do
  @moduledoc """
    BalanceSheet.Router
  """

  require Logger

  use Plug.Router

  plug :match
  plug :dispatch

  plug Plug.RequestId
  plug Plug.Logger
  plug Plug.Parsers, json_decoder: Poison,
                     parsers: [:urlencoded, :multipart, :json]

  def start_link do
    Plug.Adapters.Cowboy.http(Plugger.Router, [])
  end

  match _ do
    Logger.info('Catch all triggered. Returning 404')

    conn
    |> send_resp(404, "Oops!")
    |> halt
  end
end
