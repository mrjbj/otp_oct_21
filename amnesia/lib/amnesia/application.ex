defmodule Amnesia.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Amnesia.Game.start_link(arg)
      {DynamicSupervisor, strategy: :one_for_one, name: :sup}
    ]

    # Starts Amnesia.Supervisor with DynamicSupervisor as only child
    # Amnesia.Supervisor will use one-for-one lifecycle policy,
    # The dynamic supervisor instantiated here will also use
    # one-for-one and can be identified by name :sup
    opts = [strategy: :one_for_one, name: Amnesia.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
