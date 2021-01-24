defmodule ReservationBookWeb.UserSettingsControllerTest do
  use ReservationBookWeb.ConnCase, async: true
  use ReservationBook.FixturesHelpers

  alias ReservationBook.Accounts


  setup :register_and_log_in_user

  describe "GET /users/settings" do
    test "renders settings page", %{conn: conn} do
      conn = get(conn, Routes.user_settings_path(conn, :edit))
      response = html_response(conn, 200)
      assert response =~ "Settings</h1>"
    end

    test "redirects if user is not logged in" do
      conn = build_conn()
      conn = get(conn, Routes.user_settings_path(conn, :edit))
      assert redirected_to(conn) == Routes.user_session_path(conn, :new)
    end
  end

  describe "PUT /users/settings (change password form)" do
    test "updates the user password and resets tokens", %{conn: conn, user: user} do
      new_password_conn =
        put(conn, Routes.user_settings_path(conn, :update), %{
          "action" => "update_password",
          "current_password" => valid_user_password(),
          "user" => %{
            "password" => "new valid password",
            "password_confirmation" => "new valid password"
          }
        })

      assert redirected_to(new_password_conn) == Routes.user_settings_path(conn, :edit)
      assert get_session(new_password_conn, :user_token) != get_session(conn, :user_token)
      assert get_flash(new_password_conn, :info) =~ "Password updated successfully"
      assert Accounts.get_user_by_email_and_password(user.email, "new valid password")
    end

    test "does not update password on invalid data", %{conn: conn} do
      old_password_conn =
        put(conn, Routes.user_settings_path(conn, :update), %{
          "action" => "update_password",
          "current_password" => "invalid",
          "user" => %{
            "password" => "too short",
            "password_confirmation" => "does not match"
          }
        })

      response = html_response(old_password_conn, 200)
      assert response =~ "Settings</h1>"
      assert response =~ "should be at least 12 character(s)"
      assert response =~ "does not match password"
      assert response =~ "is not valid"

      assert get_session(old_password_conn, :user_token) == get_session(conn, :user_token)
    end
  end

  describe "PUT /users/settings (change data form)" do
    @tag :capture_log
    test "updates the user data", %{conn: conn, user: user} do
      user_data = %{
        "name" => "New valid name",
        "surname" => "New valid surname",
        "telephone" => valid_user_telephone()
      }

      new_conn =
        put(conn, Routes.user_settings_path(conn, :update), %{
          "action" => "update_user_data",
          "current_password" => valid_user_password(),
          "user" => %{
            "name" => user_data["name"],
            "surname" => user_data["surname"],
            "telephone" => user_data["telephone"]
          }
        })

      assert updated_user = Accounts.get_user_by_email(user.email)

      assert redirected_to(new_conn) == Routes.user_settings_path(conn, :edit)

      assert get_flash(new_conn, :info) =~
               "The user #{user_data["name"]} data has been successfully updated"

      assert updated_user.name == user_data["name"]
      assert updated_user.surname == user_data["surname"]
    end
  end
end
