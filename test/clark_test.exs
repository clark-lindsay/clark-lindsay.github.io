defmodule ClarkTest do
  use ExUnit.Case
  doctest Clark

  test "greets the world" do
    assert Clark.hello() == :world
  end
end
