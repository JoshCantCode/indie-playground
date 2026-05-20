defmodule KvBucket do
  use Agent

  @doc """
  Starts a new bucket.
  """
  def start_link(opts) do
    Agent.start_link(fn -> Kv.new() end, opts)
  end

  @doc """
  Returns a value from the bucket via key.
  """
  def get(bucket, key) do
    Agent.get(bucket, &Kv.get(&1, key))
  end

  @doc """
  Puts the value for the given key into the bucket

  Returns the bucket
  """
  def put(bucket, key, value) do
    Agent.update(bucket, &Kv.put(&1, key, value))
    bucket
  end

  @doc """
  Deletes the value for the given key

  Returns the bucket
  """
  def delete(bucket, key) do
    Agent.update(bucket, &Kv.delete(&1, key))
    bucket
  end

  @doc """
  Deletes the value for the given key

  Returns the deleted value
  """
  def pop(bucket, key) do
    Agent.get_and_update(bucket, &{Kv.get(&1, key), Kv.delete(&1, key)})
  end
end
