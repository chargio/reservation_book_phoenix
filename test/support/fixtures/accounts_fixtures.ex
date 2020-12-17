defmodule ReservationBook.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ReservationBook.Accounts` context.
  """

  alias ReservationBook.Repo
  alias ReservationBook.Accounts.{User, UserToken}

  # A private function that allows to create fake strings with a defined length (only lowercase letters currently)
  @spec random_string(integer) :: binary
  def random_string(length) do
    letters = String.graphemes("abcdefghijklmnopqrstuvwxyz")
    Stream.repeatedly(fn -> Enum.random(letters) end) |> Enum.take(length) |> Enum.join()
  end

  # A private function that creates fake string that represent numbers of a given length.
  # It is not an Integer but a String
  def random_number_string(length) do
    numbers = String.graphemes("0123456789")
    Stream.repeatedly(fn -> Enum.random(numbers) end) |> Enum.take(length) |> Enum.join()
  end

  @doc """
  A function to create a unique user email for tests
  It works creating a random string of 10 characters and then appending @test.com at the end of it
  """
  @spec unique_user_email :: <<_::64, _::_*8>>
  def unique_user_email, do: "#{random_string(10)}@test.com"

  @doc """
  A function to create a valid password, that can be used in tests.
  It always returns the same password, to allow for easy comparisons.
  """
  def valid_user_password, do: "Hello world!"

  @doc """
   A function that returns a valid user name, with a list of valid names
  """
  def valid_user_name, do: ~w{ Sergio Paco Pedro Juan Alicia Sara Rosa Clara } |> Enum.random()

  @doc """
  A function that returns a valid user surname, basically generating a random first surname <space> second surname
  """
  def valid_user_surname, do: "#{random_string(8)} #{random_string(6)}"

  @doc """
  A function that returns a valid user telephone, with a valid prefix, and 8 numbers afterwards
  It allows to test numbers in the format:
  +[country code][valid_first_digit][8 random_digits]
  [valid_first_digit][8 random digits]
  """
  def valid_user_telephone,
    do: (["+346", "6", "+349", "9", "+348", "8"] |> Enum.random()) <> random_number_string(8)

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
