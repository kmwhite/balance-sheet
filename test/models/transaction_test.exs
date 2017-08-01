defmodule BalanceSheet.TransactionTest do
  use BalanceSheet.ModelCase

  alias BalanceSheet.Transaction

  @valid_attrs %{
    name: "some content",
    type: :debit,
    status: :pending,
    occurred_on: %{day: 17, month: 4, year: 2010},
    amount: "123.45" |> Decimal.parse() |> elem(1)
  }
  @invalid_attrs %{type: 'orangutan'}

  @tag :skip
  test "changeset with valid attributes" do
    changeset = Transaction.changeset(%Transaction{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Transaction.changeset(%Transaction{}, @invalid_attrs)
    refute changeset.valid?
  end
end
