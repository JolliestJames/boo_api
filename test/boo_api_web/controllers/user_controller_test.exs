defmodule BooApiWeb.UserControllerTest do
  use BooApiWeb.ConnCase

  alias BooApi.Accounts
  alias BooApi.Accounts.User
  alias BooApi.Guardian

  @create_attrs %{
    email: "some@email",
    password: "password",
    password_confirmation: "password"
  }
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

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "returns a jwt when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"jwt" => jwt} = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "show user" do
    setup [:create_user]

    test "returns the user's email when valid", %{conn: conn, user: %User{id: id} = user} do
      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn = conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> get(Routes.user_path(conn, :show))

      assert %{"id" => ^id, "email" => "some@email"} = json_response(conn, 200)
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn = conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> put(Routes.user_path(conn, :update), user: @update_attrs)

      assert %{"id" => ^id, "email" => "some_updated@email"} = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      {:ok, token, _claims} = Guardian.encode_and_sign(user)


      conn = conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> put(Routes.user_path(conn, :update), user: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn = conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> delete(Routes.user_path(conn, :delete))

      assert response(conn, 204)
      assert_error_sent 404, fn -> get(conn, Routes.user_path(conn, :show)) end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
