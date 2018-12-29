defmodule BooApiWeb.UserControllerTest do
  use BooApiWeb.ConnCase

  import BooApi.Factory

  alias BooApi.Accounts.User
  alias BooApi.Guardian

  @update_attrs %{
    email: "some_updated@email",
    password: "password",
    password_confirmation: "password"
  }

  @invalid_attrs %{
    email: nil,
    password: nil,
    password_confirmation: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json"), valid: params_for(:user)}
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

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "show user" do
    setup %{conn: conn} do
      user = insert(:user)
      %User{id: id, email: email} = user
      {:ok, id: id, email: email, conn: conn |> put_auth_header(authorize(user))}
    end

    test "returns the user's email when valid", %{conn: conn, id: id, email: email} do
      conn = conn |> get(Routes.user_path(conn, :show))

      assert %{"id" => ^id, "email" => ^email} = json_response(conn, 200)
    end
  end

  describe "update user" do
    setup %{conn: conn} do
      user = insert(:user)
      %User{id: id} = user
      %{email: email} = @update_attrs
      {:ok, id: id, email: email, conn: conn |> put_auth_header(authorize(user))}
    end

    test "renders user when data is valid", %{conn: conn, id: id, email: email} do
      conn = conn |> put(Routes.user_path(conn, :update), user: @update_attrs)

      assert %{"id" => ^id, "email" => ^email} = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = conn |> put(Routes.user_path(conn, :update), user: @invalid_attrs)

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
