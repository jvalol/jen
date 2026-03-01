defmodule Jen.Repo do
  use Ecto.Repo,
    otp_app: :jen,
    adapter: Ecto.Adapters.Postgres
end
