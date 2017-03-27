defmodule BalanceSheet.Schema.Enums do
  use Absinthe.Schema.Notation

  enum :health_status_name do
    value :healthy, description: "All things are running OK"
  end
end
