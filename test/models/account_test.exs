defmodule BalanceSheet.AccountTest do
  use BalanceSheet.ModelCase

  alias BalanceSheet.Account

  @valid_attrs %{
    description: Faker.Lorem.paragraph(1),
    name: Faker.Lorem.sentence(%Range{first: 1, last: 10}),
    type: Enum.random(BalanceSheet.Enumerations.AccountType.__valid_values__())
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Account.changeset(%Account{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Account.changeset(%Account{}, @invalid_attrs)
    refute changeset.valid?
  end
end
