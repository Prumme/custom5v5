defmodule Custom5v5.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      Custom5v5Web.Telemetry,
      # Start the Ecto repository
      Custom5v5.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Custom5v5.PubSub},
      # Start Finch
      {Finch, name: Custom5v5.Finch},
      # Start the Endpoint (http/https)
      Custom5v5Web.Endpoint
      # Start a worker by calling: Custom5v5.Worker.start_link(arg)
      # {Custom5v5.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Custom5v5.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Custom5v5Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
