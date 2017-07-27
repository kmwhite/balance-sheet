defmodule BalanceSheet.Repo.Migrations.CreateTag do
  use Ecto.Migration

  def change do
    create table(:tags, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, size: 127, null: false
      add :description, :text

      timestamps()
    end

  end
end
