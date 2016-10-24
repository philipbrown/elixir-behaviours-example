defmodule Widget.Item do
  @moduledoc """
  A module that defines the Item struct
  """

  @typedoc """
  Define the Item type
  """
  @type t :: %Widget.Item{value: String.t}

  defstruct [:value]
end
