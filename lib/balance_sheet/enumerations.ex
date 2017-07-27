defmodule BalanceSheet.Enumerations do
  import EctoEnum

  defenum AccountType, :account_type, [:checking, :savings, :investment]
end
