defmodule ReservationBook.AttendeesTest do
  use ReservationBook.DataCase
  use ReservationBook.FixturesHelpers

  import ReservationBook.AttendeesFixtures

  alias ReservationBook.Attendees

  describe "minors" do
    alias ReservationBook.Attendees.Minor

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
      assert {:ok, %Minor{} = minor} = Attendees.create_minor(attrs = valid_minor_attributes())
      assert minor.age == attrs.age
      assert minor.course == attrs.course
      assert minor.name == attrs.name
      assert minor.surname == attrs.surname
    end

    test "create_minor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Attendees.create_minor(@invalid_attrs)
    end

    test "create_minor/1 with no user returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Attendees.create_minor(attrs = valid_minor_attributes(%{}, [new_user: false]))
    end

    test "create_minor/1 with a wrong user returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Attendees.create_minor(attrs = valid_minor_attributes(%{user_id: 1}, [new_user: false]))
    end

    test "update_minor/2 with valid data updates the minor" do
      minor = minor_fixture()
      assert {:ok, %Minor{} = minor} = Attendees.update_minor(minor, @update_attrs)
      assert minor.age == @update_attrs.age
      assert minor.course == @update_attrs.course
      assert minor.name == @update_attrs.name
      assert minor.surname == @update_attrs.surname
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
