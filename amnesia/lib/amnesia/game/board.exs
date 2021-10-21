defmodule Amnesia.Game.Board do
  alias Amnesia.Score
  # statuses: :playing, :won, :lost
  defstruct answer: [], guesses: []

  def new(answer \\ random()) do
    %__MODULE__{answer: answer}
  end

  def guess(board, current_guess) do
    %{board | guesses: [current_guess | board.guesses]}
  end

  def as_map(%{answer: answer, guesses: guesses} = board) do
    %{
      rows: Enum.map(guesses, fn guess -> %{guess: guess, score: get_score(answer, guess)} end),
      status: get_status(board)
    }
  end

  defp random do
    1..8
    |> Enum.shuffle()
    |> Enum.take(4)
  end

  defp get_score(answer, guess) do
    Score.new(answer, guess)
  end

  defp get_status(%{answer: answer, guesses: [answer | _guesses]}) do
    :won
  end

  defp get_status(%{guesses: guesses}) do
    if Enum.count(guesses) > 9 do
      :lost
    else
      :playing
    end
  end
end
