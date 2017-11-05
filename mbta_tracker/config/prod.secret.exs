use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :mbta_tracker, MbtaTrackerWeb.Endpoint,
  secret_key_base: "3+5DeCOFF9p0ZmF2/rk1Sac042i6sHIPSiRa3WLEpKCkG6BhVUpVyw1a6LIxHQwT"

# Configure your database
config :mbta_tracker, MbtaTracker.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "she3LeeRa4e",
  database: "mbta_tracker_prod",
  pool_size: 15
