defmodule GitreposWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :gitrepos

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
