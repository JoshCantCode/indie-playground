defmodule Kv do
  @moduledoc """
  A simple Kv store
  """
  @type key :: any
  @type value :: any
  @type t :: list({key(), value()})

  @doc """
  ## Example

     iex> Kv.new()
     []
  """
  @spec new() :: t()
  def new do
    []
  end

  @doc """
  ## Put

     iex> Kv.put([], 3, 4)
     [{3, 4}]
  """
  @spec put(t(), key(), value()) :: t()
  def put(list, key, value) do
    [{key, value} | list]
  end

  @doc """
  ## Get

     iex> Kv.get([])
     nil

     iex> Kv.get([{:a, 2}, {:b,4}], :a)
     2
  """
  @spec get(t(), key()) :: value()
  def get([]) do
    nil
  end

  def get(list, key) when is_list(list) do
    Keyword.get(list, key)
  end

  @spec get(t(), key(), value()) :: value()
  def get([], default) do
    default
  end

  def get(list, key, default) when is_list(list) do
    Keyword.get(list, key, default)
  end

  @doc """
  ## Delete

     iex> Kv.delete([{:a,4}], :a)
     []

     iex> Kv.delete([{:a,4}], :b)
     [{:a, 4}]
  """
  @spec delete(t(), key()) :: t()
  def delete(list, key) when is_list(list) do
    Keyword.delete(list, key)
  end
end
