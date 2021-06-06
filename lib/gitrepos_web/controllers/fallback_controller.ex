defmodule GitreposWeb.FallbackController do
  use GitreposWeb, :controller
  alias Gitrepos.Error
  alias GitreposWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
