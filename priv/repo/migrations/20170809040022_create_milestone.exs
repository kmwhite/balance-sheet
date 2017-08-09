defmodule BalanceSheet.Repo.Migrations.CreateMilestone do
  use Ecto.Migration

  def change do
    create table(:milestones, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false
      add :description, :text
      add :target_date, :date
      add :account_id, references(:accounts, on_delete: :nothing, type: :uuid), null: false
      add :tag_id, references(:tags, on_delete: :nothing, type: :uuid), null: false

      timestamps()
    end
    create index(:milestones, [:account_id])
    create index(:milestones, [:tag_id])

  end
end
