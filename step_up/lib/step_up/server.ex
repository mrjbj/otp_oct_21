defmodule StepUp.Server do
  alias StepUp.Core
  use GenServer
  # server
  @impl true
  def init(initial_input) do
    counter = Core.new(initial_input)
    {:ok, counter}
  end

  # get state -- reduce/convert
  @impl true
  def handle_call(:message, _from, counter) do
    message = Core.message(counter)
    {:reply, message, counter}
  end

  # increase/decrease - reduce
  @impl true
  def handle_cast(:increase, counter) do
    {:noreply, Core.increment(counter)}
  end

  @impl true
  def handle_cast(:decrease, counter) do
    {:noreply, Core.decrement(counter)}
  end

  ## Client
  def start_link(input) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, input)
  end

  def increase(pid) do
    GenServer.cast(pid, :increase)
  end

  def decrease(pid) do
    GenServer.cast(pid, :decrease)
  end

  def message(pid) do
    GenServer.call(pid, :message)
  end
end
