defmodule BalanceSheet.TagTest do
  use BalanceSheet.ModelCase

  alias BalanceSheet.Tag

  @valid_attrs %{name: Faker.Lorem.word()}
  @invalid_attrs %{description: 1, name: nil}

  test "changeset with valid attributes" do
    changeset = Tag.changeset(%Tag{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Tag.changeset(%Tag{}, @invalid_attrs)
    refute changeset.valid?
  end
end
