defmodule EtherealChat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      EtherealChatWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: EtherealChat.PubSub},
      # Start the Endpoint (http/https)
      EtherealChatWeb.Endpoint
      # Start a worker by calling: EtherealChat.Worker.start_link(arg)
      # {EtherealChat.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EtherealChat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EtherealChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
