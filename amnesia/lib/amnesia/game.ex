defmodule Amnesia.Game do
  use GenServer
  alias Amnesia.Game.Board

  #
  # Client API
  #
  def start_link(name) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, [], name: name)
  end

  def guess(pid \\ __MODULE__, numbers) do
    GenServer.call(pid, {:guess, numbers})
  end

  #
  # Callbacks
  #
  @impl true
  def init(_answer) do
    board = Board.new()
    {:ok, board}
  end

  @impl true
  def handle_call({:guess, numbers}, _from, board) do
    new_board = Board.guess(board, numbers)
    {:reply, Board.as_map(new_board), new_board}
  end

  def child_spec(name) do
    %{id: name, start: {__MODULE__, :start_link, [name]}}
  end
end
