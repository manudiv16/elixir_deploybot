defmodule ElixirDeploybotTest do
  use ExUnit.Case
  doctest ElixirDeploybot

  test "greets the world" do
    assert ElixirDeploybot.hello() == :world
  end
end
