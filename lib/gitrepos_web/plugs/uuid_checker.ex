defmodule GitreposWeb.Plugs.UUIDChecker do
  import Plug.Conn
  alias Ecto.UUID
  alias Plug.Conn

  def init(options), do: options

  def call(%Conn{params: %{"id" => id}} = conn, _options) do
    validate(conn, id)
  end

  def call(conn, _options), do: conn

  defp validate(conn, id) do
    case UUID.cast(id) do
      :error -> render_error(conn)
      {:ok, _uuid} -> conn
    end
  end

  defp render_error(conn) do
    body = Jason.encode!(%{message: "Invalid id format: not an UUID"})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(:bad_request, body)
    |> halt()
  end
end
