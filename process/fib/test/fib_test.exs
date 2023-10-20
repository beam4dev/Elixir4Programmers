defmodule FibTest do
  use ExUnit.Case
  doctest Fib

  test "greets the world" do
    assert Fib.fib(4) == 3
  end
end
