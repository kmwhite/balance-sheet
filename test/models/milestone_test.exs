defmodule BalanceSheet.MilestoneTest do
  use BalanceSheet.ModelCase

  alias BalanceSheet.Milestone

  @valid_attrs %{description: "some content", name: "some content", target_date: %{day: 17, month: 4, year: 2010}}
  @invalid_attrs %{}

  setup _context do
    account = Repo.insert!(struct(BalanceSheet.Account, %{
      description: Faker.Lorem.paragraph(1),
      name: Faker.Lorem.sentence(%Range{first: 1, last: 10}),
      type: Enum.random(BalanceSheet.Enumerations.AccountType.__valid_values__())
    }))
    tag = Repo.insert!(struct(BalanceSheet.Tag, %{
      description: Faker.Lorem.paragraph(1),
      name: Faker.Lorem.sentence(%Range{first: 1, last: 10}),
    }))
    attributes = Map.merge(@valid_attrs,
                           %{account_id: Map.get(account, :id),
                             tag_id: Map.get(tag, :id)})

    {:ok, attributes: attributes}
  end

  test "changeset with valid attributes", %{attributes: attributes} do
    {old_params, new_params} = Map.split(attributes, [:tag_id, :account_id])
    milestone = struct(%Milestone{}, old_params)
    changeset = Milestone.changeset(milestone, new_params)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Milestone.changeset(%Milestone{}, @invalid_attrs)
    refute changeset.valid?
  end
end
