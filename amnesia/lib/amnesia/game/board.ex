defmodule Amnesia.Game.Board do
  # statuses: :playing, :won, :lost
  defstruct answer: [], guesses: []

  def new(answer \\ random()) do
    %__MODULE__{answer: answer}
  end

  def guess(board, current_guess) do
    %{board | guesses: [current_guess | board.guesses]}
  end

  defp random do
    1..8
    |> Enum.shuffle()
    |> Enum.take(4)
  end
end
