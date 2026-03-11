defmodule ImportError.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ImportErrorWeb.Telemetry,
      ImportError.Repo,
      {DNSCluster, query: Application.get_env(:import_error, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ImportError.PubSub},
      # Start a worker by calling: ImportError.Worker.start_link(arg)
      # {ImportError.Worker, arg},
      # Start to serve requests, typically the last entry
      ImportErrorWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ImportError.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ImportErrorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
