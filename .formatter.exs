[
  import_deps: [:ecto, :ecto_sql, :ash, :ash_postgres],
  subdirectories: ["priv/*/migrations"],
  inputs: [
    "*.{heex,ex,exs}",
    "{config,lib,test}/**/*.{ex,exs}",
    "priv/support/**/*.{ex,exs}",
    "priv/*/*.exs",
  ]
]
