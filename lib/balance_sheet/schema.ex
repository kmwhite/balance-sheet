defmodule BalanceSheet.Schema do
  @moduledoc """
  BalanceSheet Schema Definition
  """

  require Logger

  def health_check(_, args, _) do
    resp = %{status: :healthy, message: inspect(args)}

    Logger.info("healthCheck returning a #{inspect(resp)}")
    {:ok, resp}
  end

  use Absinthe.Schema

  import_types BalanceSheet.Schema.Types
  import_types BalanceSheet.Schema.Enums

  query do
    field :host_health, :health_status do
      description "Host Health Check"

      resolve &BalanceSheet.Schema.health_check/3
    end
  end

  #mutation do
  #end
end
