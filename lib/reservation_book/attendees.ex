defmodule ReservationBook.Attendees do
  @moduledoc """
  The Attendees context.
  """

  import Ecto.Query, warn: false
  alias ReservationBook.Repo

  alias ReservationBook.Attendees.Minor

  @doc """
  Returns the list of minors.

  ## Examples

      iex> list_minors()
      [%Minor{}, ...]

  """
  def list_minors do
    Repo.all(Minor)
  end

  @doc """
  Gets a single minor.

  Raises `Ecto.NoResultsError` if the Minor does not exist.

  ## Examples

      iex> get_minor!(123)
      %Minor{}

      iex> get_minor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_minor!(id), do: Repo.get!(Minor, id)

  @doc """
  Creates a minor.

  ## Examples

      iex> create_minor(%{field: value})
      {:ok, %Minor{}}

      iex> create_minor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_minor(attrs \\ %{}) do
    %Minor{}
    |> Minor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a minor.

  ## Examples

      iex> update_minor(minor, %{field: new_value})
      {:ok, %Minor{}}

      iex> update_minor(minor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_minor(%Minor{} = minor, attrs) do
    minor
    |> Minor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a minor.

  ## Examples

      iex> delete_minor(minor)
      {:ok, %Minor{}}

      iex> delete_minor(minor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_minor(%Minor{} = minor) do
    Repo.delete(minor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking minor changes.

  ## Examples

      iex> change_minor(minor)
      %Ecto.Changeset{data: %Minor{}}

  """
  def change_minor(%Minor{} = minor, attrs \\ %{}) do
    Minor.changeset(minor, attrs)
  end
end
