defmodule ACPartTwoTest do
  use ExUnit.Case

  alias AC.PartTwo

  doctest AC.PartTwo

  test "run/0" do
    path = "test.txt"
    File.write!(path, "A Y\nB X\nC Z")

    score = PartTwo.calc(path)
    File.rm(path)

    assert score == 12
  end
end
