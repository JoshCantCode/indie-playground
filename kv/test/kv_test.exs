defmodule KvTest do
  use ExUnit.Case, async: true
  import Kv

  doctest Kv

  test "new/0 returns empty set" do
    assert new() |> Enum.empty?()
  end

  test "get/2 returns value set in preceding put" do
    k = :a
    v = 1

    assert new() |> put(k, v) |> get(k) == v
  end

  test "get/3 returns a default if key is not found" do
    k = :b
    v = 2

    assert new() |> put(:e, v) |> get(k, :nope) == :nope
  end

  test "put/2 overwrites existing value for given key" do
    k = :c
    v = 3

    assert new() |> put(k,v) |> put(k, v+1) |> get(k) == v+1
  end

  test "delete/2 removes key from set" do
    k = :d
    v = 4
    assert new() |> put(k,v) |> delete(k) |> get(k, :nope) == :nope
  end
end
