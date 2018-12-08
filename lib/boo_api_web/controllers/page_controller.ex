defmodule BooApiWeb.PageController do
  use BooApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
