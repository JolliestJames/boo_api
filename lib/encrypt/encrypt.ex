defmodule BooApi.Encrypt do
  @encryption_api Application.get_env(:boo_api, :encryption_api)

  def encrypt(password) do
    @encryption_api.encrypt(password)
  end
end
