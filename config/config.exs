# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :chat,
  ecto_repos: [Chat.Repo]

# Configures the endpoint
config :chat, ChatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SqRurkkmq/7D6uFBN05NpCedLwUDBhW8FSR5EoIfk3DXcQNcLm4hS08rJdT4qVDf",
  render_errors: [view: ChatWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Chat.PubSub,
  live_view: [signing_salt: "v9zbk2S3"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
