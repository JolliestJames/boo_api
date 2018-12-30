defmodule BooApi.EncryptionApi.Bcrypt do
  @behaviour BooApi.EncryptionApi

  @impl BooApi.EncryptionApi
  def encrypt(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end
end
