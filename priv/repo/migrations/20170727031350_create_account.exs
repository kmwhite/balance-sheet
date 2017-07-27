defmodule BalanceSheet.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def up do
    BalanceSheet.Enumerations.AccountType.create_type
    create table(:accounts, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, size: 255, null: false
      add :description, :text
      add :type, :account_type, null: false

      timestamps()
    end
  end

  def down do
    drop table(:accounts)
    BalanceSheet.Enumerations.AccountType.drop_type
  end
end
