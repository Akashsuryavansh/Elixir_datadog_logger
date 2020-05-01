defmodule DatadogClientTest do
  use ExUnit.Case
  doctest DatadogClient

  test "greets the world" do
    assert DatadogClient.hello() == :world
  end
end
