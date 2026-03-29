defmodule GasTownTest.Repo do
  use Ecto.Repo,
    otp_app: :gas_town_test,
    adapter: Ecto.Adapters.Postgres
end
