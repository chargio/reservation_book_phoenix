defmodule ReservationBook.Attendees.Minor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "minors" do
    field :age, :integer
    field :course, :string
    field :name, :string
    field :surname, :string
    belongs_to :user, ReservationBook.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(minor, attrs) do
    minor
    |> cast(attrs, [:name, :surname, :age, :course, :user_id])
    |> validate_required([:name, :surname, :age, :course, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end
