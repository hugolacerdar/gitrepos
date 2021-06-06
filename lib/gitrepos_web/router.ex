defmodule GitreposWeb.Router do
  use GitreposWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GitreposWeb do
    pipe_through :api

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
