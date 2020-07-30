defmodule ClassManager.Repo do
  use Ecto.Repo,
    otp_app: :class_manager,
    adapter: Ecto.Adapters.Postgres
end
