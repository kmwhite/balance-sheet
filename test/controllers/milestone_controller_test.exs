defmodule BalanceSheet.MilestoneControllerTest do
  use BalanceSheet.ConnCase

  alias BalanceSheet.Milestone
  @valid_attrs %{
    description: "some content",
    name: "some content",
    target_date: %{day: 17, month: 4, year: 2010} |> Ecto.Date.cast |> elem(1)
  }
  @invalid_attrs %{description: 2}

  setup %{conn: conn} do
    new_conn = put_req_header(conn, "accept", "application/json")
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

    {:ok, conn: new_conn, attributes: attributes}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, milestone_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn, attributes: attributes} do
    milestone = Repo.insert!(struct(%Milestone{}, attributes))
    conn = get conn, milestone_path(conn, :show, milestone)
    assert json_response(conn, 200)["data"] == %{"id" => milestone.id,
      "name" => milestone.name,
      "description" => milestone.description,
      "target_date" => Ecto.Date.to_iso8601(milestone.target_date),
      "account_id" => milestone.account_id,
      "tag_id" => milestone.tag_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, milestone_path(conn, :show, "249ae36c-af10-426d-b179-52c2c4f61fd2")
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn, attributes: attributes} do
    conn = post conn, milestone_path(conn, :create), milestone: attributes
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Milestone, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, milestone_path(conn, :create), milestone: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn, attributes: attributes} do
    milestone = Repo.insert!(struct(%Milestone{}, attributes))
    conn = put conn, milestone_path(conn, :update, milestone), milestone: attributes
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Milestone, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn, attributes: attributes} do
    milestone = Repo.insert!(struct(%Milestone{}, attributes))
    conn = put conn, milestone_path(conn, :update, milestone), milestone: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn, attributes: attributes} do
    milestone = Repo.insert! struct(%Milestone{}, attributes)
    conn = delete conn, milestone_path(conn, :delete, milestone)
    assert response(conn, 204)
    refute Repo.get(Milestone, milestone.id)
  end
end
