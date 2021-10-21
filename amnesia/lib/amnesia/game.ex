defmodule Amnesia.Game do
  use GenServer
  alias Amnesia.Game.Board

  #
  # Client API
  #
  def start_link(answer) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, answer, name: __MODULE__)
  end

  def guess(pid \\ __MODULE__, numbers) do
    GenServer.cast(pid, {:guess, numbers})
  end

  #
  # Callbacks
  #
  @impl true
  def init(answer) do
    board = Board.new(answer)
    {:ok, board}
  end

  @impl true
  def handle_cast({:guess, numbers}, board) do
    board = Board.guess(board, numbers)
    {:noreply, board}
  end
end
