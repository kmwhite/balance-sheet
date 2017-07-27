defmodule BalanceSheet.Account do
  use BalanceSheet.Web, :model

  schema "accounts" do
    field :name, :string
    field :description, :string
    field :type, BalanceSheet.Enumerations.AccountType

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :type])
    |> validate_required([:name, :description, :type])
  end
end
