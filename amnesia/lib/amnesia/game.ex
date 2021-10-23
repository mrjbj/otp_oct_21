defmodule Amnesia.Game do
  use GenServer
  alias Amnesia.Game.Board

  @moduledoc """
  Client API, interacts with GenServer process to initialize, make guesses
    - Amnesia.Game.start_link(:jason) to initialize a new game named :jason in it's own process.
    - Amnesia.Game.guess(:jason, [1,2,3,4])
  """

  @doc """
  start_link: constructor. Takes name for child process, starts new game with that name.
  """
  def start_link(name) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, [], name: name)
  end

  @doc """
  guess: API. takes new guess, calls into server to retrieve new board after guess.
  """
  def guess(pid \\ __MODULE__, numbers) do
    GenServer.call(pid, {:guess, numbers})
  end

  # GenServer Callback functions
  # These functions must be implemented by developer seeking to leverage
  # GenServer process container for their process.
  #  - init: invoked by GenServer framework as the process first starts up.
  #  - handle_call: invoked synchronously, when client expects a reply back.
  #  - handle_cast: invoked asynchronously, when client does not expect reply back.
  @impl true
  @doc """
  invoked by GenServer upon process start.
  creats a new board struct, which includes answer: and guesses:
  """
  def init(_answer) do
    board = Board.new()
    {:ok, board}
  end

  @impl true
  @doc """
  GenServer interface function that allows client to make a guess.
  Client passes in a guess along with current state of board.
  :guess keyword tuple returns new board
  """
  def handle_call({:guess, numbers}, _from, board) do
    new_board = Board.guess(board, numbers)
    {:reply, Board.as_map(new_board), new_board}
  end

  # starts up an Amnesia.Game with specified name (like :jason)
  # called by supervisor after API.start_link to allow child process to specify it's configuration policy
  def child_spec(name) do
    %{id: name, start: {__MODULE__, :start_link, [name]}}
  end
end
