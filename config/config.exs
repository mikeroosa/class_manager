# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :class_manager,
  ecto_repos: [ClassManager.Repo]

# Configures the endpoint
config :class_manager, ClassManagerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IcFW2sa3WxjfFCT8g+2cjDG/GNL2KD3zqH1rKpItzYz+ltVQYQLdMa16eNQJmoBJ",
  render_errors: [view: ClassManagerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ClassManager.PubSub,
  live_view: [signing_salt: "ZnzMoTDZ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
