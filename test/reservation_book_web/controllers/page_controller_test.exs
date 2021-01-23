defmodule ReservationBookWeb.PageControllerTest do
  use ReservationBookWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to ReservationBook!"
  end
end
