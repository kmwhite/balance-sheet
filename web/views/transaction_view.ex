defmodule BalanceSheet.TransactionView do
  use BalanceSheet.Web, :view

  def render("index.json", %{transactions: transactions}) do
    %{data: render_many(transactions, BalanceSheet.TransactionView, "transaction.json")}
  end

  def render("show.json", %{transaction: transaction}) do
    %{data: render_one(transaction, BalanceSheet.TransactionView, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{id: transaction.id,
      name: transaction.name,
      occurred_on: transaction.occurred_on,
      amount: transaction.amount,
      account_id: transaction.account_id,
      tag_id: transaction.tag_id}
  end
end
