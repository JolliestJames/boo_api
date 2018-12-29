defmodule BooApi.AccountsTest do
  use BooApi.DataCase

  import Comeonin.Bcrypt, only: [check_pass: 2]
  import BooApi.Factory

  alias BooApi.Accounts
  alias BooApi.Accounts.User

  @valid_attrs %{
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

  setup do
    user = insert(:user)
    {:ok, user: Accounts.get_user!(user.id)}
  end

  describe "create_user/1" do
    test "with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == @valid_attrs[:email]
      assert check_pass(user, @valid_attrs[:password]) == {:ok, user}
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end
  end

  describe "list_users/0" do
    test "returns all users", %{user: user} do
      assert Accounts.list_users() == [user]
    end
  end

  describe "get_user!/1" do
    test "returns the user with given id", %{user: user} do
      assert %User{} = Accounts.get_user!(user.id)
    end
  end

  describe "update_user/2" do
    test "with valid data updates the user", %{user: user} do
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == @update_attrs[:email]
      assert check_pass(user, @update_attrs[:password]) == {:ok, user}
    end

    test "with invalid data returns error changeset", %{user: user} do
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end
  end

  describe "change_user/1" do
    test "change_user/1 returns a user changeset", %{user: user} do
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "delete_user/1" do
    test "deletes the user", %{user: user} do
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end
  end
end
