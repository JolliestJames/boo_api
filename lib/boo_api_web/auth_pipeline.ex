defmodule BooApi.Guardian.AuthPipeline do
  @moduledoc """
  Authentication pipeline for verfying a resource is authenticated with Guardian before accessing certain controller actions
  """

  use Guardian.Plug.Pipeline, otp_app: :BooApi,
  module: BooApi.Guardian,
  error_handler: BooApi.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
