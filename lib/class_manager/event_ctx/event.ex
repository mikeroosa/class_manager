defmodule ClassManager.EventCtx.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :scheduled_for, :naive_datetime
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:title, :scheduled_for])
    |> validate_required([:title, :scheduled_for])
  end
end
