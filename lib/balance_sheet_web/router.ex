defmodule BalanceSheetWeb.Router do
  use BalanceSheetWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BalanceSheetWeb do
    pipe_through :api
  end
end
