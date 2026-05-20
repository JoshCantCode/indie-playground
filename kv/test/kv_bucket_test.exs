defmodule KvBucketTest do
  use ExUnit.Case, async: true
  import KvBucket

  test "stores values by key" do
    {:ok, bucket} = start_link([])
    assert get(bucket, "milk") == nil

    put(bucket, "milk", 3)
    assert get(bucket, "milk") == 3
  end

  test "stores values by key on a named bucket" do
    {:ok, _} = start_link(name: :recipe)
    assert get(:recipe, "eggs") == nil

    put(:recipe, "eggs", 2)
    assert get(:recipe, "eggs") == 2
  end

  test "delete/2 returns value deleted" do
    {:ok, bucket} = start_link([])

    a =
      put(bucket, "eggs", :a)
      |> put("butter", 1.5)
      |> put("whisk", true)
      |> put("temp", 400)
      |> pop("eggs")

    assert a == :a
  end
end
