defmodule Gitrepos.Repo do
  use Ecto.Repo,
    otp_app: :gitrepos,
    adapter: Ecto.Adapters.Postgres
end
