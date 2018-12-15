defmodule BooApi.Guardian do
  use Guardian, otp_app: :boo_api

  def subject_for_token(user, _claims) do
    subject = to_string(user.id)
    {:ok, subject}
  end

  def resource_from_claims(claims) do
    id = claims["subject"]
  end
end
