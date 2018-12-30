# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :boo_api,
  ecto_repos: [BooApi.Repo]

# Configures the endpoint
config :boo_api, BooApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nN5M5WH+BggDvrudwHo4FWvaupmYAyBjTzJIcRQeDMsW6Enf0DH5QJeMHCq6mGQ4",
  render_errors: [view: BooApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: BooApi.PubSub, adapter: Phoenix.PubSub.PG2]

config :boo_api, BooApi.Guardian,
  issuer: "BooApi",
  secret_key: System.get_env("GUARDIAN_SECRET")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :boo_api, :encryption_api, BooApi.EncryptionApi.Bcrypt

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
