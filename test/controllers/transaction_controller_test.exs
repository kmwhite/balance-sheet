defmodule BalanceSheet.TransactionControllerTest do
  use BalanceSheet.ConnCase

  alias BalanceSheet.Transaction

  @valid_attrs %{
    type: :credit,
    amount: "120.5" |> Decimal.parse |> elem(1),
    name: %Range{first: 1, last: 8} |> Faker.Lorem.words() |> Enum.join(" "),
    occurred_on: %{day: 17, month: 4, year: 2010} |> Ecto.Date.cast |> elem(1),
    status: :pending
  }
  @invalid_attrs %{name: 1}

  setup %{conn: conn} do
    new_conn = put_req_header(conn, "accept", "application/json")
    account = Repo.insert!(struct(BalanceSheet.Account, %{
      description: Faker.Lorem.paragraph(1),
      name: Faker.Lorem.sentence(%Range{first: 1, last: 10}),
      type: Enum.random(BalanceSheet.Enumerations.AccountType.__valid_values__())
    }))

    {:ok, conn: new_conn, account: account}
  end

  test "lists all entries on index", context do
    conn = get context[:conn], transaction_path(context[:conn], :index)
    assert json_response(conn, 200)["data"] == []
  end

  @tag :skip
  test "shows chosen resource", %{conn: conn} do
    transaction = Repo.insert!(struct(Transaction, @valid_attrs))
    conn = get conn, transaction_path(conn, :show, transaction)
    Enum.each(~w(name occurred_on amount account_id tag_id), fn(param) ->
      assert json_response(conn, 200)["data"][param] == transaction[param]
    end)
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, transaction_path(conn, :show, "f3861b74-e625-43ab-803d-d3ae7ac203e5")
    end
  end

  @tag :skip
  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, transaction_path(conn, :create), transaction: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Transaction, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, transaction_path(conn, :create), transaction: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  @tag :skip
  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    transaction = Repo.insert!(struct(Transaction, @valid_attrs))
    conn = put conn, transaction_path(conn, :update, transaction), transaction: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Transaction, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    transaction = Repo.insert!(struct(Transaction, @valid_attrs))
    conn = put conn, transaction_path(conn, :update, transaction), transaction: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    transaction = Repo.insert!(struct(Transaction, @valid_attrs))
    conn = delete conn, transaction_path(conn, :delete, transaction)
    assert response(conn, 204)
    refute Repo.get(Transaction, transaction.id)
  end
end
