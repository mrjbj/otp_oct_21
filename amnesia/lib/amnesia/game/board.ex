defmodule Amnesia.Game.Board do
  # statuses: :playing, :won, :lost
  defstruct answer: [], guesses: [], status: :playing

  def new(answer \\ [1, 2, 3, 4]) do
    %__MODULE__{answer: answer}
  end

  def random do
    1..8
    |> Enum.shuffle()
    |> Enum.take(4)
    |> new()
  end

  def guess(board, current_guess) do
    %{board | guesses: [current_guess | board.guesses]}
  end

  def as_map(%{status: :playing} = board) do
    Map.from_struct(board)
  end
end
