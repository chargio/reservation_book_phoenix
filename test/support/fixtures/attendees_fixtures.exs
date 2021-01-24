defmodule ReservationBook.AttendeesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ReservationBook.Accounts` context.
  """

  alias ReservationBook.Repo
  alias ReservationBook.Attendees.Minor
  alias ReservationBook.Attendees
  alias ReservationBook.AccountsFixtures
  use ReservationBook.FixturesHelpers

  @valid_attrs %{age: 12, course: "primary first", name: "some name", surname: "some surname"}
  @update_attrs %{age: 13, course: "primary second", name: "some updated name", surname: "some updated surname"}
  @invalid_attrs %{age: nil, course: nil, name: nil, surname: nil}

  def minor_fixture(attrs \\ %{}) do
    {:ok, minor} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Attendees.create_minor()

    minor
  end

end
