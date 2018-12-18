defmodule BooApi.Guardian do
  use Guardian, otp_app: :boo_api
  require IEx
  def subject_for_token(user, _claims) do
    subject = to_string(user.id)
    {:ok, subject}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = BooApi.Accounts.get_user!(id)
    {:ok, resource}
  end
end
