defmodule GitreposWeb.ReposController do
  use GitreposWeb, :controller

  alias GitreposWeb.Auth.Guardian
  alias GitreposWeb.FallbackController

  action_fallback FallbackController

  def get_all(conn, %{"username" => username}) do
    with {:ok, repositories} <- Gitrepos.get_filtered_repo_data(username) do
      current_token = Guardian.Plug.current_token(conn)
      {:ok, _old_stuff, {refresh_token, _new_claims}} = Guardian.refresh(current_token)

      conn
      |> put_status(:ok)
      |> render("show.json", repositories: repositories, refresh_token: refresh_token)
    end
  end
end
