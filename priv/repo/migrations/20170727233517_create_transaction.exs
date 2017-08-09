defmodule BalanceSheet.Repo.Migrations.CreateTransaction do
  use Ecto.Migration

  def up do
    BalanceSheet.Enumerations.TransactionStatus.create_type
    BalanceSheet.Enumerations.TransactionType.create_type
    create table(:transactions, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false
      add :occurred_on, :date, null: false
      add :amount, :decimal, null: false
      add :type, :transaction_type, null: false
      add :status, :transaction_status, null: false
      add :account_id, references(:accounts, on_delete: :nothing, type: :uuid)
      add :tag_id, references(:tags, on_delete: :nothing, type: :uuid)

      timestamps()
    end
  end

  def down do
    drop table(:transactions)
    BalanceSheet.Enumerations.TransactionType.drop_type
    BalanceSheet.Enumerations.TransactionStatus.drop_type
  end
end
