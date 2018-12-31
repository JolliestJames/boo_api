use Mix.Config

# Split these up into different files depending on the environment (test.secret.exs, dev.secret.exs, etc.)

# config.secret.exs
config :boo_api, BooApi.Guardian,
  issuer: "BooApi",
  secret_key: "<mix phx.gen.secret>"

# dev.secret.exs
config :boo_api, BooApi.Repo,
  username: "postgres",
  password: "postgres",
  database: "dev_database",
  hostname: "localhost",
  pool_size: 10

# prod.secret.exs
config :boo_api, BooApi.Repo,
  username: "postgres",
  password: "postgres",
  database: "prod_database",
  pool_size: 15

config :boo_api, BooApiWeb.Endpoint,
  secret_key_base: "<mix phx.gen.secret>"

# test.secret.exs
config :boo_api, BooApi.Repo,
  username: "postgres",
  password: "postgres",
  database: "test_database",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
