defmodule KvBucket do
  use Agent

  @doc """
  Starts a new bucket.
  """
  def start_link(opts) do
    Agent.start_link(fn -> Kv.new() end, opts)
  end

  @doc """
  Gets a value from the bucket via key.
  """
  def get(bucket, key) do
    Agent.get(bucket, &Kv.get(&1, key))
  end

  @doc """
  Puts the value for the given key into the bucket
  """
  def put(bucket, key, value) do
    Agent.update(bucket, &Kv.put(&1, key, value))
  end

  @doc """
  Deletes the value for the given key
  """
  def delete(bucket, key) do
    Agent.update(bucket, &Kv.delete(&1, key))
  end
end
