defmodule BooApiWeb.UserControllerTest do
  use BooApiWeb.ConnCase

  import BooApi.Factory

  alias BooApi.Guardian

  setup %{conn: conn} do
    {
      :ok,
      conn: put_req_header(conn, "accept", "application/json"),
      valid: params_for(:user),
      update: %{
        email: "some_updated@email",
        password: "password",
        password_confirmation: "password"
      },
      invalid: %{
        email: nil,
        password: nil,
        password_confirmation: nil
      }
    }
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "returns a jwt when data is valid", %{conn: conn, valid: valid} do
      conn = post(conn, Routes.user_path(conn, :create), user: valid)
      assert %{"jwt" => jwt} = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, invalid: invalid} do
      conn = post(conn, Routes.user_path(conn, :create), user: invalid)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "show user" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, user: user, conn: conn |> put_auth_header(authorize(user))}
    end

    test "returns the user's email when valid", %{conn: conn, user: user} do
      conn = conn |> get(Routes.user_path(conn, :show))

      assert %{"id" => user.id, "email" => user.email} == json_response(conn, 200)
    end
  end

  describe "update user" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, user: user, conn: conn |> put_auth_header(authorize(user))}
    end

    test "renders user when data is valid", %{conn: conn, user: user, update: update} do
      conn = conn |> put(Routes.user_path(conn, :update), user: update)

      assert %{"id" => user.id, "email" => update[:email]} == json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, invalid: invalid} do
      conn = conn |> put(Routes.user_path(conn, :update), user: invalid)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup %{conn: conn} do
      {:ok, conn: conn |> put_auth_header(authorize(insert(:user)))}
    end

    test "deletes chosen user", %{conn: conn} do
      conn = conn |> delete(Routes.user_path(conn, :delete))

      assert response(conn, 204)
      assert_error_sent 404, fn -> get(conn, Routes.user_path(conn, :show)) end
    end
  end

  defp authorize(user) do
    {:ok, token, _claims} = Guardian.encode_and_sign(user)
    token
  end

  defp put_auth_header(conn, token) do
    put_req_header(conn, "authorization", "Bearer #{token}")
  end
end
