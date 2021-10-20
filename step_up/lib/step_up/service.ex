defmodule StepUp.Service do
  alias StepUp.Core

  def listen(counter) do
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

  def run(state) do
    state
    |> listen
    |> run
  end

  def start(initial_input) do
    intial_state = Core.new(initial_input)
    spawn(fn -> run(intial_state) end)
  end
end
