defmodule ClassManager.Repo.Migrations.CreateCampaigns do
  use Ecto.Migration

  def change do
    create table(:campaigns) do
      add :subject, :string
      add :body, :text

      timestamps()
    end

  end
end
