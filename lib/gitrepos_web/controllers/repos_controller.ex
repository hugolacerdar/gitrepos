defmodule GitreposWeb.ReposController do
  use GitreposWeb, :controller

  alias GitreposWeb.FallbackController

  action_fallback FallbackController

  def get_all(conn, %{"username" => username}) do
    with {:ok, repositories} <- Gitrepos.get_filtered_repo_data(username) do
      conn
      |> put_status(:ok)
      |> render("show.json", repositories: repositories)
    end
  end
end
