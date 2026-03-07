defmodule Jen.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      JenWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:jen, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Jen.PubSub},
      # Start a worker by calling: Jen.Worker.start_link(arg)
      # {Jen.Worker, arg},
      # Start to serve requests, typically the last entry
      JenWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Jen.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JenWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
