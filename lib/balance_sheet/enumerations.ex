defmodule BalanceSheet.Enumerations do
  import EctoEnum

  defenum AccountType, :account_type, [:checking, :savings, :investment]
  defenum TransactionStatus, :transaction_status, [:pending, :committed, :voided]
  defenum TransactionType, :transaction_type, [:debit, :credit]
end
