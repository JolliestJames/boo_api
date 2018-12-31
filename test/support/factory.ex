defmodule BooApi.Factory do
  @moduledoc """
  Import this module to include every factory instead of each one individually
  """

  use ExMachina.Ecto, repo: BooApi.Repo
  use BooApi.UserFactory
end
