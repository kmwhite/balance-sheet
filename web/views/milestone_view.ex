defmodule BalanceSheet.MilestoneView do
  use BalanceSheet.Web, :view

  def render("index.json", %{milestones: milestones}) do
    %{data: render_many(milestones, BalanceSheet.MilestoneView, "milestone.json")}
  end

  def render("show.json", %{milestone: milestone}) do
    %{data: render_one(milestone, BalanceSheet.MilestoneView, "milestone.json")}
  end

  def render("milestone.json", %{milestone: milestone}) do
    %{id: milestone.id,
      name: milestone.name,
      description: milestone.description,
      target_date: milestone.target_date,
      account_id: milestone.account_id,
      tag_id: milestone.tag_id}
  end
end
