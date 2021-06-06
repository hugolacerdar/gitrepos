defmodule GitreposWeb.ReposView do
  use GitreposWeb, :view

  def render("show.json", %{repositories: repositories}), do: %{result: repositories}
end
