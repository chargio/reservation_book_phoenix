defmodule ReservationBook.AttendeesTest do
  use ReservationBook.DataCase
  use ReservationBook.FixturesHelpers

  import ReservationBook.AttendeesFixtures

  alias ReservationBook.Attendees

  describe "minors" do
    alias ReservationBook.Attendees.Minor

    @valid_attrs %{age: 12, course: "primary first", name: "some name", surname: "some surname"}
    @update_attrs %{age: 13, course: "primary second", name: "some updated name", surname: "some updated surname"}
    @invalid_attrs %{age: nil, course: nil, name: nil, surname: nil}


    test "list_minors/0 returns all minors" do
      minor = minor_fixture()
      assert Attendees.list_minors() == [minor]
    end

    test "get_minor!/1 returns the minor with given id" do
      minor = minor_fixture()
      assert Attendees.get_minor!(minor.id) == minor
    end

    test "create_minor/1 with valid data creates a minor" do
      assert {:ok, %Minor{} = minor} = Attendees.create_minor(@valid_attrs)
      assert minor.age == 12
      assert minor.course == "primary first"
      assert minor.name == "some name"
      assert minor.surname == "some surname"
    end

    test "create_minor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Attendees.create_minor(@invalid_attrs)
    end

    test "update_minor/2 with valid data updates the minor" do
      minor = minor_fixture()
      assert {:ok, %Minor{} = minor} = Attendees.update_minor(minor, @update_attrs)
      assert minor.age == 13
      assert minor.course == "primary second"
      assert minor.name == "some updated name"
      assert minor.surname == "some updated surname"
    end

    test "update_minor/2 with invalid data returns error changeset" do
      minor = minor_fixture()
      assert {:error, %Ecto.Changeset{}} = Attendees.update_minor(minor, @invalid_attrs)
      assert minor == Attendees.get_minor!(minor.id)
    end

    test "delete_minor/1 deletes the minor" do
      minor = minor_fixture()
      assert {:ok, %Minor{}} = Attendees.delete_minor(minor)
      assert_raise Ecto.NoResultsError, fn -> Attendees.get_minor!(minor.id) end
    end

    test "change_minor/1 returns a minor changeset" do
      minor = minor_fixture()
      assert %Ecto.Changeset{} = Attendees.change_minor(minor)
    end
  end
end
