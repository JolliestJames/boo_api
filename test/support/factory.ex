defmodule BooApi.Factory do
  use ExMachina.Ecto, repo: BooApi.Repo
  use BooApi.UserFactory
end
