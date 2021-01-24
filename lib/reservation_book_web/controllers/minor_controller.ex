defmodule ReservationBookWeb.MinorController do
  use ReservationBookWeb, :controller

  alias ReservationBook.Attendees
  alias ReservationBook.Attendees.Minor

  def index(conn, _params) do
    minors = Attendees.list_minors()
    render(conn, "index.html", minors: minors)
  end

  def new(conn, _params) do
    changeset = Attendees.change_minor(%Minor{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"minor" => minor_params}) do
    case Attendees.create_minor(minor_params) do
      {:ok, minor} ->
        conn
        |> put_flash(:info, "Minor created successfully.")
        |> redirect(to: Routes.minor_path(conn, :show, minor))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    minor = Attendees.get_minor!(id)
    render(conn, "show.html", minor: minor)
  end

  def edit(conn, %{"id" => id}) do
    minor = Attendees.get_minor!(id)
    changeset = Attendees.change_minor(minor)
    render(conn, "edit.html", minor: minor, changeset: changeset)
  end

  def update(conn, %{"id" => id, "minor" => minor_params}) do
    minor = Attendees.get_minor!(id)

    case Attendees.update_minor(minor, minor_params) do
      {:ok, minor} ->
        conn
        |> put_flash(:info, "Minor updated successfully.")
        |> redirect(to: Routes.minor_path(conn, :show, minor))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", minor: minor, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    minor = Attendees.get_minor!(id)
    {:ok, _minor} = Attendees.delete_minor(minor)

    conn
    |> put_flash(:info, "Minor deleted successfully.")
    |> redirect(to: Routes.minor_path(conn, :index))
  end
end
