defmodule ReservationBook.Repo do
  use Ecto.Repo,
    otp_app: :reservation_book,
    adapter: Ecto.Adapters.Postgres
end
