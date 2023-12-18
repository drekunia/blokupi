defmodule Blokupi.Repo do
  use Ecto.Repo,
    otp_app: :blokupi,
    adapter: Ecto.Adapters.Postgres
end
