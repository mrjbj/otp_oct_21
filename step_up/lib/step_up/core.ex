defmodule StepUp.Core do

  def increment(map, step \\ 1), do: %{map | counter: map.counter + step}

  def decrement(map, step \\ 1), do: increment(map, -step)
end
