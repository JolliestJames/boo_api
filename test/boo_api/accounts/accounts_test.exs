defmodule BooApi.AccountsTest do
  use BooApi.DataCase

  import Comeonin.Bcrypt, only: [check_pass: 2]
  import BooApi.Factory

  alias BooApi.Accounts
  alias BooApi.Accounts.User

  setup do
    user = insert(:user)
    {
      :ok,
      user: Accounts.get_user!(user.id),
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

  describe "create_user/1" do
    test "with valid data creates a user", %{valid: valid} do
      assert {:ok, %User{} = user} = Accounts.create_user(valid)
      assert user.email == valid[:email]
      assert check_pass(user, valid[:password]) == {:ok, user}
    end

    test "with invalid data returns error changeset", %{invalid: invalid} do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(invalid)
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
    test "with valid data updates the user", %{user: user, update: update} do
      assert {:ok, %User{} = user} = Accounts.update_user(user, update)
      assert user.email == update[:email]
      assert check_pass(user, update[:password]) == {:ok, user}
    end

    test "with invalid data returns error changeset", %{user: user, invalid: invalid} do
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, invalid)
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
