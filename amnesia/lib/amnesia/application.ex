defmodule Amnesia.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Amnesia.Worker.start_link(arg)
      # {Amnesia.Worker, arg}
      {Amnesia.Game, :abul},
      {Amnesia.Game, :bruno},
      {Amnesia.Game, :john},
      {Amnesia.Game, :jason},
      {Amnesia.Game, :kevin},
      {Amnesia.Game, :nader},
      {Amnesia.Game, :bruce}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Amnesia.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
