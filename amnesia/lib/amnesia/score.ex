defmodule Amnesia.Score do
  defstruct [:reds,  :whites]

  def new(answer, guess) do
    reds = guess
           |> Enum.zip(answer)
           |> Enum.count(fn {x, y} -> x == y end)
    misses = (guess -- answer) |> Enum.count
    total = 4
    whites = (total - misses - reds)
    %__MODULE__{reds: reds, whites: whites}
  end

  # def as_string(%{reds: reds, whites: whites}) do
  #   "RRWW"

  # end

end
