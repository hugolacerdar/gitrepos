# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :gitrepos,
  ecto_repos: [Gitrepos.Repo]

config :gitrepos, Gitrepos.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :gitrepos, GitreposWeb.Auth.Guardian,
  issuer: "gitrepos",
  secret_key: "nqK4wYQM9QLnfJwN7QZJGu5Mv6uwrFLH9Q9vP0k07ndzhPwmEfAlnPt7FmmHVI15",
  ttl: {1, :minute}

config :gitrepos, GitreposWeb.Auth.Pipeline,
  module: GitreposWeb.Auth.Guardian,
  error_handler: GitreposWeb.Auth.ErrorHandler

# Configures the endpoint
config :gitrepos, GitreposWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UCqFFckgXILa6nSXilqAxaf2u2esxhZu2n6xVmP3BRutnmvaGlWv05e7W5ez5xPz",
  render_errors: [view: GitreposWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Gitrepos.PubSub,
  live_view: [signing_salt: "MI2Wwk5U"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
