defmodule BalanceSheet.MilestoneController do
  use BalanceSheet.Web, :controller

  alias BalanceSheet.Milestone

  def index(conn, _params) do
    milestones = Repo.all(Milestone)
    render(conn, "index.json", milestones: milestones)
  end

  def create(conn, %{"milestone" => milestone_params}) do
    changeset = Milestone.changeset(%Milestone{}, milestone_params)

    case Repo.insert(changeset) do
      {:ok, milestone} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", milestone_path(conn, :show, milestone))
        |> render("show.json", milestone: milestone)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(BalanceSheet.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    milestone = Repo.get!(Milestone, id)
    render(conn, "show.json", milestone: milestone)
  end

  def update(conn, %{"id" => id, "milestone" => milestone_params}) do
    milestone = Repo.get!(Milestone, id)
    changeset = Milestone.changeset(milestone, milestone_params)

    case Repo.update(changeset) do
      {:ok, milestone} ->
        render(conn, "show.json", milestone: milestone)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(BalanceSheet.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    milestone = Repo.get!(Milestone, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(milestone)

    send_resp(conn, :no_content, "")
  end
end
