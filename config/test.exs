use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :boo_api, BooApiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Import db config
import_config "secrets/test.secret.exs"

config :bcrypt_elixir, log_rounds: 4
