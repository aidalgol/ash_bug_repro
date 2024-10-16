import Config

config :hello,
  ecto_repos: [Hello.Repo],
  generators: [timestamp_type: :utc_datetime],
  ash_domains: [Hello.Market]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
