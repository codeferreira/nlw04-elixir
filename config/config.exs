# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rocketpay,
  ecto_repos: [Rocketpay.Repo]

# Configures the endpoint
config :rocketpay, RocketpayWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VwEbwJqZ3hGt1WpplpWfwLWtlzaGBWm83OxbpIHvWrLdervNTHlxF74qX1/xYH7L",
  render_errors: [view: RocketpayWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Rocketpay.PubSub,
  live_view: [signing_salt: "DMHXSriU"]

config :rocketpay, Rocketpay.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :rocketpay, :basic_auth,
  username: "banana",
  password: "nanica123"

config :rocketpay, Rocketpay.Guardian,
  issuer: "rocketpay",
  secret_key: "hfxqXshW8vvra4sfQk/EKMNIjrig086JWiaAIeV5eteaNWg+UIf8nsvkPF9gx3BH"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
