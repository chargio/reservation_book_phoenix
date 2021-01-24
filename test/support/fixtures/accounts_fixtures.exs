defmodule ReservationBook.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ReservationBook.Accounts` context.
  """

  alias ReservationBook.Repo
  alias ReservationBook.Accounts.{User, UserToken}
  use ReservationBook.FixturesHelpers

  @doc """
  A funtion that returns a Struct with all the required fields filled.
  It allows the user to include their own attrs in the creation
  """
  def valid_user_attributes(attrs \\ %{}) do
    attrs
    |> Enum.into(%{
      email: unique_user_email(),
      password: valid_user_password(),
      password_confirmation: valid_user_password(),
      name: valid_user_name(),
      surname: valid_user_surname(),
      telephone: valid_user_telephone(),
      comments: nil
    })
  end

  @doc """
  Creates a valid user using valid_user_attributes and registers it so it can be used in tests
  """
  def user_fixture(attrs \\ %{}, opts \\ []) do
    {:ok, user} =
      valid_user_attributes(attrs)
      |> ReservationBook.Accounts.register_user()

    if Keyword.get(opts, :confirmed, true), do: Repo.transaction(confirm_user_multi(user))
    user
  end

  def extract_user_token(fun) do
    {:ok, captured} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token, _] = String.split(captured.body, "[TOKEN]")
    token
  end

  # Confirms the user and deletes the token
  defp confirm_user_multi(user) do
    Ecto.Multi.new()
    |> Ecto.Multi.update(:user, User.confirm_changeset(user))
    |> Ecto.Multi.delete_all(:tokens, UserToken.user_and_contexts_query(user, ["confirm"]))
  end
end
