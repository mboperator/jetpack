# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
# config :jetpack_phoenix,
#   ecto_repos: [JetpackPhoenix.Repo]

# Configures the endpoint
config :jetpack_phoenix, JetpackPhoenix.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Q2FPTL3oNu2LJFqqWLCfrUVtplf4e8zSo1hk329miJINzADTZ1fn1QA8ugPpS8IT",
  render_errors: [view: JetpackPhoenix.ErrorView, accepts: ~w(html json)],
  pubsub: [name: JetpackPhoenix.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
