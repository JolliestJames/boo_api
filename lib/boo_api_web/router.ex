defmodule BooApiWeb.Router do
  use BooApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BooApiWeb do
    pipe_through :api
  end
end
