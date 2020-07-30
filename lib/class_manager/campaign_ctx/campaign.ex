defmodule ClassManager.CampaignCtx.Campaign do
  use Ecto.Schema
  import Ecto.Changeset

  schema "campaigns" do
    field :body, :string
    field :subject, :string

    timestamps()
  end

  @doc false
  def changeset(campaign, attrs) do
    campaign
    |> cast(attrs, [:subject, :body])
    |> validate_required([:subject, :body])
  end
end
