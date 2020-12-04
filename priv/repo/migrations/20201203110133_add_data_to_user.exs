defmodule ReservationBook.Repo.Migrations.AddDataToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :name, :string
      add :surname, :string
      add :telephone, :string
      add :comments, :text
    end

    create index("users", [:telephone])
  end
end
