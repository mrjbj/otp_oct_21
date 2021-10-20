defmodule StepUp.Service do
  alias StepUp.Core

  def increase(counter) do
    send(counter, :increase)
    counter
  end

  def decrease(counter) do
    send(counter, :decrease)
    counter
  end

  def message(counter) do
    send(counter, {:state, self()})
    receive do
      message -> message
    end
  end

  defp listen(counter) do
    receive do
      :increase ->
        Core.increment(counter)
      :decrease ->
        Core.decrement(counter)
      {:state, from}  ->
        send(from, Core.message(counter))
        counter
    end
  end

  defp run(state) do
    state
    |> listen
    |> run
  end

  def start(initial_input) do
    intial_state = Core.new(initial_input)
    spawn(fn -> run(intial_state) end)
  end
end
