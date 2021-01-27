defmodule ReservationBook.Repo.Migrations.AddDataToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :name, :string, null: false
      add :surname, :string, null: false
      add :telephone, :string, null: false
      add :comments, :text
    end

    create index("users", [:telephone])
  end
end
