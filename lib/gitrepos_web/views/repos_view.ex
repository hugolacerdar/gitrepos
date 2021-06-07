defmodule GitreposWeb.ReposView do
  use GitreposWeb, :view

  def render("show.json", %{repositories: repositories, refresh_token: refresh_token}),
    do: %{result: repositories, refresh_token: refresh_token}
end
