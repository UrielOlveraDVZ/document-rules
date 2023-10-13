defmodule DocumentRulesTest do
  use ExUnit.Case
  doctest DocumentRules

  test "greets the world" do
    assert DocumentRules.hello() == :world
  end
end
