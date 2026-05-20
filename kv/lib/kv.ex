defmodule Kv do
  @moduledoc """
  A simple Kv store
  """
  @type key :: any
  @type value :: any
  @type t :: map()

  @doc """
  ## Example

     iex> Kv.new()
     %{}
  """
  @spec new() :: t()
  def new do
    %{}
  end

  @doc """
  ## Put

     iex> Kv.put(%{}, 3, 4)
     %{3 => 4}

     iex> Kv.put(%{3 => 2}, 3, 4)
     %{3 => 4}
  """
  @spec put(t(), key(), value()) :: t()
  def put(map, key, value) do
    Map.put(map, key, value)
  end

  @doc """
  ## Get
     iex> Kv.get(%{a: 2, b: 4}, :a)
     2

     iex> Kv.get(%{a: 2, b: 4}, :b)
     4

     iex> Kv.get(%{a: 2, b: 4}, :c)
     nil
  """
  @spec get(t(), key(), value()) :: value()
  def get(map, key, default \\ nil) when is_map(map) do
    Map.get(map, key, default)
  end

  @doc """
  ## Delete

     iex> Kv.delete(%{a: 4}, :a)
     %{}

     iex> Kv.delete(%{a: 4}, :b)
     %{a: 4}
  """
  @spec delete(t(), key()) :: t()
  def delete(map, key) when is_map(map) do
    {Map.get(map, key), Map.delete(map, key)}
  end
end
