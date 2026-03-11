defmodule ImportError.Repo do
  use Ecto.Repo,
    otp_app: :import_error,
    adapter: Ecto.Adapters.MyXQL
end
