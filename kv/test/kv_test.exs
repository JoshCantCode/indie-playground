defmodule KvTest do
  use ExUnit.Case, async: true
  doctest Kv

  test "Validate that a new KV is empty" do
    assert Kv.new() |> Enum.empty?()
  end

  test "Same item is pushed and popped" do
    k = :rand.uniform(50)
    assert Kv.new() |> Kv.put(k) |> Kv.get() == k
  end

  test "Inserting multiple values doesn't clobber" do
    k = :rand.uniform(50)
    kv = Kv.new() |> Kv.put(k) |> Kv.put(k + 1)
    assert Enum.member?(kv, k)
    assert Enum.member?(kv, k + 1)
    assert Enum.count(kv) == 2
  end

  test "delete value from KV" do
    k = :rand.uniform(50)
    kv = Kv.new() |> Kv.put(k) |> Kv.put(k + 1)
    assert Kv.delete(kv) |> Enum.count() == 1
  end

  test "get first value of KV" do
    k = :rand.uniform(50)
    kv = Kv.new() |> Kv.put(k) |> Kv.put(k + 1)
    assert Kv.delete(kv) |> Kv.get() == k
  end
end
