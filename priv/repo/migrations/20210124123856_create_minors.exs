defmodule ReservationBook.Repo.Migrations.CreateMinors do
  use Ecto.Migration

  def change do
    create table(:minors) do
      add :name, :string, null: false
      add :surname, :string, null: false
      add :age, :integer, null: false
      add :course, :string, null: false
      add :user_id, references("users", on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:minors, [:user_id])
  end
end
