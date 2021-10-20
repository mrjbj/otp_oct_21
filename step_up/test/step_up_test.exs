defmodule StepUpTest do
  use ExUnit.Case
  doctest StepUp

  test "new returns map with input as integer" do
    assert StepUp.new("100") == %{count: 100}
  end
end
