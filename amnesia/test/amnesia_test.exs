defmodule AmnesiaTest do
  use ExUnit.Case
  doctest Amnesia

  test "greets the world" do
    assert Amnesia.hello() == :world
  end
end
