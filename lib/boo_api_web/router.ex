defmodule BooApiWeb.Router do
  use BooApiWeb, :router

  alias BooApi.Guardian

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/api/v1", BooApiWeb do
    pipe_through :api

    post "/sign_in", UserController, :sign_in
    post "/sign_up", UserController, :create
  end

  scope "/api/v1", BooApiWeb do
    pipe_through [:api, :jwt_authenticated]

    delete "/user/delete", UserController, :delete
    put "/user/update", UserController, :update
    get "/user", UserController, :show
  end

  scope "/api", BooApiWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit, :show]
  end
end
