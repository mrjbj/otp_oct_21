defmodule BoardTest do
  use ExUnit.Case
  import Amnesia.Game.Board

  test "CRC works!" do
    test_board()
    |> assert_status(:playing)
    |> guess([1, 2, 3, 5])
    |> assert_status(:playing)
    |> guess([1, 2, 3, 4])
    |> assert_status(:won)
  end

  def assert_status(board, status) do
    actual_status = as_map(board).status
    assert(actual_status == status)
    board
  end

  def test_board do
    new([1, 2, 3, 4])
  end
end

# fred herbert : property based testing
