defmodule Widget.Store do
  @moduledoc """
  A behaviour module for defining a store
  """

  alias Widget.Item

  @doc """
  Save an item and return it's id
  """
  @callback save(item :: Item.t) :: {:ok, integer}

  @doc """
  Find an item by it's id
  """
  @callback find(id :: integer) :: {:ok, Item.t} | {:error, :not_found}

  @doc """
  Count the number of items
  """
  @callback count :: integer
end
