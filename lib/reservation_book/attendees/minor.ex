defmodule ReservationBook.Attendees.Minor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "minors" do
    field :age, :integer
    field :course, :string
    field :name, :string
    field :surname, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(minor, attrs) do
    minor
    |> cast(attrs, [:name, :surname, :age, :course])
    |> validate_required([:name, :surname, :age, :course])
  end
end
