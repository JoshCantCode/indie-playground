defmodule Kv do
  @moduledoc """
  A simple Kv store
  """
  @type item :: any()
  @type t :: [item()] | []

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

     iex> Kv.put(3, [])
     [3]

     iex> Kv.put(3, [1,2,3])
     [3, 1, 2, 3]
  """
  # edited to fix piping, because piping inserts the value at the first index. should probably do this for all functions if i plan to pipe them :p
  @spec put(t(), item()) :: t()
  def put(list, item) do
    [item | list]
  end

  @doc """
  ## Get

     iex> Kv.get([])
     nil

     iex> Kv.get([1,2,3])
     1
  """
  @spec get(t()) :: item()
  def get([]) do
    nil
  end

  def get([item | _tail]) do
    item
  end

  @doc """
  ## Delete

     iex> Kv.delete([1,2,3])
     [2, 3]

     iex> Kv.delete([])
     ** (FunctionClauseError) no function clause matching in Kv.delete/1

  """
  # @spec delete(t()) :: t()
  def delete([_head | tail]) do
    tail
  end
end
