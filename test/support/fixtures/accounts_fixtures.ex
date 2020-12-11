defmodule ReservationBook.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ReservationBook.Accounts` context.
  """

  # Required to create fake strings
  defp random_string(length) do
    letters = String.graphemes("abcdefghijklmnopqrstuvwxyz")
    Stream.repeatedly(fn -> Enum.random(letters) end) |> Enum.take(length) |> Enum.join()
  end

  # Required to create fake string that represent numbers of a given length
  defp random_number_string(length) do
    numbers = String.graphemes("0123456789")
    Stream.repeatedly(fn -> Enum.random(numbers) end) |> Enum.take(length) |> Enum.join()
  end

  @spec unique_user_email :: <<_::64, _::_*8>>
  def unique_user_email, do: "#{random_string(10)}@test.com"

  def valid_user_password, do: "Hello world!"

  def valid_user_name, do: ~w{ Sergio Paco Pedro Juan Alicia Sara Rosa Clara } |> Enum.random()

  def valid_user_surname, do: "#{random_string(8)} #{random_string(6)}"

  def valid_user_phone,
    do: (["+346", "6", "+349", "9", "+348", "8"] |> Enum.random()) <> random_number_string(8)

  def valid_user_attributes(attrs \\ %{}) do
    attrs
    |> Enum.into(%{
      email: unique_user_email(),
      password: valid_user_password(),
      name: valid_user_name(),
      surname: valid_user_surname(),
      telephone: valid_user_phone(),
      comments: nil
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      valid_user_attributes(attrs)
      |> ReservationBook.Accounts.register_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token, _] = String.split(captured.body, "[TOKEN]")
    token
  end
end
