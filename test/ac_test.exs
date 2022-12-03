defmodule ACTest do
  use ExUnit.Case

  doctest AC

  test "run/0" do
    path = "test.txt"
    # win player 2 - p1: 1, p2: 8*
    # win player 1 - p1: 8, p2: 1*
    # tie - p1: 6, p2: 6
    # totals: p1: 15, p2: 15
    File.write!(path, "A Y\nB X\nC Z")

    score = AC.calc(path)
    File.rm(path)

    assert score == 15
  end
end
