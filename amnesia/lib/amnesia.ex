defmodule Amnesia do
  def start_game(name) do
   {:ok, _pid}= DynamicSupervisor.start_child(:sup, {Amnesia.Game, name})
  end
# :bruce
  def guess(name, guess) do
   Amnesia.Game.guess(name, guess)
  end
end
