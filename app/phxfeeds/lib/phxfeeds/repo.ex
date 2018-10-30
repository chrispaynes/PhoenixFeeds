defmodule Phxfeeds.Repo do
  use Ecto.Repo,
    otp_app: :phxfeeds,
    adapter: Ecto.Adapters.Postgres
end
