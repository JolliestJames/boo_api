defmodule BooApi.Repo do
  use Ecto.Repo,
    otp_app: :boo_api,
    adapter: Ecto.Adapters.Postgres
end
