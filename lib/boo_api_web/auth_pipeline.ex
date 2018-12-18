defmodule BooApi.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :BooApi,
  module: BooApi.Guardian,
  error_handler: BooApi.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
