defmodule Amnesia.Game.Board do
  @moduledoc """
  Board is a struct of correct answer and list of guesses

  Public:
   - new: (constructor) takes a pre-computed answer or generates a random answer with empty set of guesses
   - guess: (reducer) takes current board and prepends new guess on top of it.
   - as_map: (converter) takes answer & guesses, returns map of rows
                containing a guess and score for each guess, along with status of :playing | :lost | :won
  """
  alias Amnesia.Score
  # statuses: :playing, :won, :lost
  defstruct answer: [], guesses: []

  @doc """
  constructor: return new answer or random answer if not supplied
  """
  def new(answer \\ random()) do
    %__MODULE__{answer: answer}
  end

  @doc """
  prepend current_guess to list of guesses
  """
  def guess(board, current_guess) do
    %{board | guesses: [current_guess | board.guesses]}
  end

  #
  def as_map(%{answer: answer, guesses: guesses} = board) do
    %{
      rows: Enum.map(guesses, fn guess -> %{guess: guess, score: get_score(answer, guess)} end),
      status: get_status(board)
    }
  end

  # seed answer as random value
  defp random do
    1..8
    |> Enum.shuffle()
    |> Enum.take(4)
  end

  # returns {reds: n, whites: n}
  defp get_score(answer, guess) do
    Score.new(answer, guess)
  end

  # will match if most recent guess equals answer, so return :won
  defp get_status(%{answer: answer, guesses: [answer | _guesses]}) do
    :won
  end

  # pulls out list of guesses, return :lost if > 9 else :playing
  defp get_status(%{guesses: guesses}) do
    if Enum.count(guesses) > 9 do
      :lost
    else
      :playing
    end
  end
end
