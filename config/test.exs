use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :pakex, Pakex.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :pakex, Pakex.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "pakex_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
