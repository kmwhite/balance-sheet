defmodule BalanceSheet.Schema.Types do
  use Absinthe.Schema.Notation

  object :health_status do
    field :status, :health_status_name
    field :message, :string
  end
end
