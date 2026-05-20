defmodule KvBucket do
  use GenServer

  @doc """
  Starts a new GenServer.
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, Kv.new(), opts)
  end

  @doc """
  Returns a value from the bucket via key.
  """
  def get(bucket, key) do
    GenServer.call(bucket, {:get, key})
  end

  @doc """
  Puts the value for the given key into the bucket

  Returns the bucket
  """
  def put(bucket, key, value) do
    GenServer.call(bucket, {:put, key, value})
    bucket
  end

  @doc """
  Deletes the value for the given key

  Returns the bucket
  """
  # ideally i'd like to return both the value deleted and the bucket so i can keep piping, but not sure if i can do that
  # this also removes the need of the pop
  def delete(bucket, key) do
    GenServer.call(bucket, {:delete, key})
    bucket
  end

  @doc """
  Deletes the value for the given key

  Returns the deleted value
  """
  def pop(bucket, key) do
    GenServer.call(bucket, {:delete, key})
  end

  @impl true
  def init(bucket) do
    state = %{
      bucket: bucket,
      subscribers: MapSet.new()
    }

    {:ok, state}
  end

  @impl true
  def handle_call({:put, key, value}, _from, state) do
    state = put_in(state.bucket[key], value)
    broadcast(state, {:put, key, value})
    {:reply, :ok, state}
  end

  def handle_call({:get, key}, _from, state) do
    {:reply, Kv.get(state.bucket, key), state}
  end

  def handle_call({:delete, key}, _from, state) do
    {value, state} = pop_in(state.bucket[key])
    broadcast(state, {:delete, key})
    {:reply, value, state}
  end

  def handle_call({:delete, key}, _from, state) do
    {value, state} = pop_in(state.bucket[key])
    {:reply, value, state}
  end

  defp broadcast(state, message) do
    for pid <- state.subscribers do
      send(pid, message)
    end
  end

  @doc """
  Subscribes the current process to the bucket.
  """
  def subscribe(bucket) do
    GenServer.cast(bucket, {:subscribe, self()})
  end

  @impl true
  def handle_cast({:subscribe, pid}, state) do
    Process.monitor(pid)
    state = update_in(state.subscribers, &MapSet.put(&1, pid))
    {:noreply, state}
  end

  @impl true
  def handle_info({:DOWN, _ref, _type, pid, _reason}, state) do
    state = update_in(state.subscribers, &MapSet.delete(&1, pid))
    {:noreply, state}
  end
end
