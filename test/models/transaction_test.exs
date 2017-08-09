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

  setup _context do
    account = Repo.insert!(struct(BalanceSheet.Account, %{
      description: Faker.Lorem.paragraph(1),
      name: Faker.Lorem.sentence(%Range{first: 1, last: 10}),
      type: Enum.random(BalanceSheet.Enumerations.AccountType.__valid_values__())
    }))
    attributes = Map.merge(@valid_attrs, %{account_id: Map.get(account, :id)})

    {:ok, attributes: attributes}
  end

  test "changeset with valid attributes", %{attributes: attributes} do
    changeset = Transaction.changeset(%Transaction{}, attributes)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Transaction.changeset(%Transaction{}, @invalid_attrs)
    refute changeset.valid?
  end
end
