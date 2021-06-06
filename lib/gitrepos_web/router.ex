defmodule GitreposWeb.Router do
  use GitreposWeb, :router
  alias GitreposWeb.Plugs.UUIDChecker

  pipeline :api do
    plug :accepts, ["json"]
    plug UUIDChecker
  end

  pipeline :auth do
    plug GitreposWeb.Auth.Pipeline
    plug UUIDChecker
  end

  scope "/api", GitreposWeb do
    pipe_through :api

    post "/users", UsersController, :create
    post "/users/signin", UsersController, :sign_in
  end

  scope "/api", GitreposWeb do
    pipe_through :auth

    get "/repos/:username", ReposController, :get_all
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: GitreposWeb.Telemetry
    end
  end
end
