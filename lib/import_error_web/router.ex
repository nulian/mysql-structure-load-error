defmodule ImportErrorWeb.Router do
  use ImportErrorWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ImportErrorWeb do
    pipe_through :api
  end
end
