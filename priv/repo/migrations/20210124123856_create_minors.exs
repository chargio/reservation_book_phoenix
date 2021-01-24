defmodule ReservationBook.Repo.Migrations.CreateMinors do
  use Ecto.Migration

  def change do
    create table(:minors) do
      add :name, :string
      add :surname, :string
      add :age, :integer
      add :course, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:minors, [:user_id])
  end
end
