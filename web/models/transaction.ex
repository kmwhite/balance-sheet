defmodule BalanceSheet.Transaction do
  use BalanceSheet.Web, :model

  schema "transactions" do
    field :name, :string
    field :occurred_on, Ecto.Date
    field :amount, :decimal
    field :type, BalanceSheet.Enumerations.TransactionType
    field :status, BalanceSheet.Enumerations.TransactionStatus
    belongs_to :account, BalanceSheet.Account
    belongs_to :tag, BalanceSheet.Tag

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :type, :status, :occurred_on, :amount, :account_id, :tag_id])
    |> foreign_key_constraint(:account_id)
    |> foreign_key_constraint(:tag_id)
    |> validate_required([:name, :type, :status, :occurred_on, :amount, :account_id])
  end
end
