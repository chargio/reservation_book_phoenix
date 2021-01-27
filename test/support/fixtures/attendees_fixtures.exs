defmodule ReservationBook.AttendeesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ReservationBook.Accounts` context.
  """

  # alias ReservationBook.Repo
  # alias ReservationBook.Attendees.Minor
  alias ReservationBook.Attendees
  alias ReservationBook.AccountsFixtures
  use ReservationBook.FixturesHelpers

  @valid_attrs %{course: "primary first", age: 11}

  def valid_minor_attributes(attrs \\ %{}, options \\ []) do

   user_id = case Keyword.get(options, :new_user, true) do
      true -> AccountsFixtures.user_fixture().id
      _ -> nil
    end

    attrs
    |> Enum.into(%{
      name: valid_user_name(),
      surname: valid_user_surname(),
      course: @valid_attrs.course,
      age: @valid_attrs.age,
      user_id: user_id
    })

  end

  def minor_fixture(attrs \\ %{}, options \\ []) do
    {:ok, minor} =
      valid_minor_attributes(attrs, options)
      |> Attendees.create_minor()
    minor
  end

end
