defmodule Amnesia.Score do
  @moduledoc """
  Provides clues to help guessers refine next guess
    - Red: guess is correct number in correct position
    - white: guess is correct but in wrong position

  Public:
    - new: takes answer and guess and returns it's red/white score
    - as_string: takes a score and returns the result as a string of "R" and "W"
  """
  defstruct [:reds, :whites]

  @doc """
  take [answer] and [guess] and return %{reds: n, whites: n}
  """
  def new(answer, guess) do
    reds =
      guess
      |> Enum.zip(answer)
      |> Enum.count(fn {x, y} -> x == y end)

    misses = (guess -- answer) |> Enum.count()
    total = 4
    whites = total - misses - reds
    %__MODULE__{reds: reds, whites: whites}
  end

  @doc """
  converter: take %Score{} return "RRWW" string representing :reds and :whites
  """
  def as_string(%{reds: reds, whites: whites}) do
    String.duplicate("R", reds) <> String.duplicate("W", whites)
  end
end
