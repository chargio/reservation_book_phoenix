defmodule ReservationBookWeb.MinorControllerTest do
  use ReservationBookWeb.ConnCase
  use ReservationBook.FixturesHelpers

  import ReservationBook.Attendees

  alias ReservationBook.Attendees


  @create_attrs %{age: 42, course: "some course", name: "some name", surname: "some surname"}
  @update_attrs %{age: 43, course: "some updated course", name: "some updated name", surname: "some updated surname"}
  @invalid_attrs %{age: nil, course: nil, name: nil, surname: nil}

  def fixture(:minor) do
    {:ok, minor} = Attendees.create_minor(@create_attrs)
    minor
  end

  describe "index" do
    test "lists all minors", %{conn: conn} do
      conn = get(conn, Routes.minor_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Minors"
    end
  end

  describe "new minor" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.minor_path(conn, :new))
      assert html_response(conn, 200) =~ "New Minor"
    end
  end

  describe "create minor" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.minor_path(conn, :create), minor: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.minor_path(conn, :show, id)

      conn = get(conn, Routes.minor_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Minor"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.minor_path(conn, :create), minor: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Minor"
    end
  end

  describe "edit minor" do
    setup [:create_fake_minor]

    test "renders form for editing chosen minor", %{conn: conn, minor: minor} do
      conn = get(conn, Routes.minor_path(conn, :edit, minor))
      assert html_response(conn, 200) =~ "Edit Minor"
    end
  end

  describe "update minor" do
    setup [:create_fake_minor]

    test "redirects when data is valid", %{conn: conn, minor: minor} do
      conn = put(conn, Routes.minor_path(conn, :update, minor), minor: @update_attrs)
      assert redirected_to(conn) == Routes.minor_path(conn, :show, minor)

      conn = get(conn, Routes.minor_path(conn, :show, minor))
      assert html_response(conn, 200) =~ "some updated course"
    end

    test "renders errors when data is invalid", %{conn: conn, minor: minor} do
      conn = put(conn, Routes.minor_path(conn, :update, minor), minor: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Minor"
    end
  end

  describe "delete minor" do
    setup [:create_fake_minor]

    test "deletes chosen minor", %{conn: conn, minor: minor} do
      conn = delete(conn, Routes.minor_path(conn, :delete, minor))
      assert redirected_to(conn) == Routes.minor_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.minor_path(conn, :show, minor))
      end
    end
  end

  defp create_fake_minor(_) do
    minor = fixture(:minor)
    %{minor: minor}
  end
end
