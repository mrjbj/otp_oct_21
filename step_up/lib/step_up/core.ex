defmodule StepUp.Core do
  def new(input), do: %{count: String.to_integer(input)}

  def increment(map, step \\ 1), do: %{map | count: map.count + step}

  def decrement(map, step \\ 1), do: increment(map, -step)

  def message(%{count: count}) do
    "the final value is #{count}"
  end
end
