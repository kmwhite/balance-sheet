defmodule BalanceSheet.Router do
  use BalanceSheet.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BalanceSheet do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", BalanceSheet do
    pipe_through :api
    resources "/accounts", AccountController, except: [:new, :edit]
    resources "/tags", TagController, except: [:new, :edit]
    resources "/transactions", TransactionController, except: [:new, :edit]
    resources "/milestones", MilestoneController, except: [:new, :edit]
  end
end
