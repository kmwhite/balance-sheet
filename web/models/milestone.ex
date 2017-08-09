defmodule BalanceSheet.Milestone do
  use BalanceSheet.Web, :model

  schema "milestones" do
    field :name, :string
    field :description, :string
    field :target_date, Ecto.Date
    belongs_to :account, BalanceSheet.Account
    belongs_to :tag, BalanceSheet.Tag

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :target_date, :account_id, :tag_id])
    |> foreign_key_constraint(:account_id)
    |> validate_required([:name, :description, :target_date, :account_id])
  end
end
