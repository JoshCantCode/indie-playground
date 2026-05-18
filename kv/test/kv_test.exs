defmodule KvTest do
  use ExUnit.Case
  # disable doctests so i can easily see the tests i make here
  # doctest Kv

  test "create new KV" do
    assert Kv.new() == []
  end

  test "add value to new KV" do
    assert Kv.put(Kv.new(), 5) == [5]
  end

  test "add value to existing KV" do
    assert Kv.put([1, 2, 3], 5) == [5, 1, 2, 3]
  end

  test "delete value from KV" do
    assert Kv.delete([1, 2, 3]) == [2, 3]
  end

  test "get first value of KV" do
    assert Kv.get([1, 2, 3]) == 1
  end

  describe "independent implementation" do
    test "new KV is empty" do
      assert Kv.get(Kv.new()) == nil
    end

    test "getting from a KV with only a single item returns said item" do
      kv = Kv.put(Kv.new(), 5)
      assert Kv.get(kv) == 5
    end

    test "deleting only removes the most recent item" do
      # learned this from my own experimenting, |> basically replaces the argument needed in functions with the parent, in this Kv.new()
      # therefore theres no need to pass it into Kv.put(item, list)
      # and the same with .delete()
      kv =
        Kv.new()
        |> Kv.put(1)
        |> Kv.put(2)
        |> Kv.put(3)
        |> Kv.delete()

      assert kv == [2, 1]
    end
  end
end
