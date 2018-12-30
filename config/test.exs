use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :boo_api, BooApiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :boo_api, BooApi.Repo,
  username: System.get_env("DB_USERNAME"),
  password: System.get_env("DB_PASSWORD"),
  database: "boo_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :boo_api, :encryption_api, BooApi.EncryptionApi.MockBcrypt
