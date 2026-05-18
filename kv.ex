defmodule KV do
  @moduledoc """
  A simple KV store
  """
  @type item :: any()
  @type t :: [item()]

  @doc """
  ## Example

     iex> KV.new()
     []
  """
  @spec new() :: t()
  def new do
    []
  end

  @spec put(item(), t()) :: t()
  def put(item, list) do
    [item | list]
  end

  @spec get(t()) :: item()
  def get([]) do
    nil
  end

  def get([item | _tail]) do
    item
  end

  @spec delete(t()) :: t()
  def delete([_head | tail]) do
    tail
  end
end
