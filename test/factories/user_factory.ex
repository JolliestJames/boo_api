defmodule BooApi.UserFactory do
  @moduledoc """
  Factory for users
  """

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %BooApi.Accounts.User{
          email: sequence(:email, &"email#{&1}@test.com"),
          password: "password",
          password_confirmation: "password"
        }
      end
    end
  end
end
