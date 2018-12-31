defmodule BooApi.AuthErrorHandler do
  @moduledoc """
  Error handling for when calls to authenticated routes fail due to not being authenticated
  """

  import Plug.Conn

  def auth_error(conn, {type, _reason}, _opts) do
    body = Jason.encode(%{error: to_string(type)})
    send_resp(conn, 401, body)
  end
end
