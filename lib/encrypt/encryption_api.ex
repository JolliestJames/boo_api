defmodule BooApi.EncryptionApi do
  @callback encrypt(password :: String.t()) ::
    {:ok, String.t()}
end
