defmodule BalanceSheet.TagView do
  use BalanceSheet.Web, :view

  def render("index.json", %{tags: tags}) do
    %{data: render_many(tags, BalanceSheet.TagView, "tag.json")}
  end

  def render("show.json", %{tag: tag}) do
    %{data: render_one(tag, BalanceSheet.TagView, "tag.json")}
  end

  def render("tag.json", %{tag: tag}) do
    %{id: tag.id,
      name: tag.name,
      description: tag.description}
  end
end
