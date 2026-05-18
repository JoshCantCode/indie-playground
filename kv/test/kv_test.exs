defmodule KvTest do
  use ExUnit.Case
  # disable doctests so i can easily see the tests i make here
  # doctest Kv

  test "create new KV" do
    assert Kv.new() == []
  end

  test "add value to new KV" do
    assert Kv.put(5, Kv.new()) == [5]
  end

  test "add value to existing KV" do
    assert Kv.put(5, [1, 2, 3]) == [5, 1, 2, 3]
  end

  test "delete value from KV" do
    assert Kv.delete([1, 2, 3]) == [2, 3]
  end

  test "get first value of KV" do
    assert Kv.get([1, 2, 3]) == 1
  end
end
