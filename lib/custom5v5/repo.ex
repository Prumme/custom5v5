defmodule Custom5v5.Repo do
  use Ecto.Repo,
    otp_app: :custom5v5,
    adapter: Ecto.Adapters.Postgres
end
