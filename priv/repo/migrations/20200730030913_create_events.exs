defmodule ClassManager.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :title, :string
      add :scheduled_for, :naive_datetime

      timestamps()
    end

  end
end
