defmodule Widget.ETSStore do
  @behaviour Widget.Store

  alias Widget.Item

  ##################################################
  # Set up
  ##################################################

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    :ets.new(__MODULE__, [:ordered_set, :private, :named_table])

     {:ok, :ok}
  end

  ##################################################
  # Public
  ##################################################

  @spec save(Item.t) :: {:ok, integer}
  def save(item) do
    GenServer.call(__MODULE__, {:save, item})
  end

  @spec find(integer) :: {:ok, Item.t} | {:error, :not_found}
  def find(id) do
    GenServer.call(__MODULE__, {:find, id})
  end

  @spec count :: integer
  def count do
    GenServer.call(__MODULE__, {:count})
  end

  ##################################################
  # Callbacks
  ##################################################

  def handle_call({:save, item}, _from, :ok) do
    id = next_id

    :ets.insert(__MODULE__, {id, item})

    {:reply, {:ok, id}, :ok}
  end

  def handle_call({:find, id}, _from, :ok) do
    reply = case :ets.lookup(__MODULE__, id) do
      [{^id, item}] -> {:ok, item}
      [] -> {:error, :not_found}
    end

    {:reply, reply, :ok}
  end

  def handle_call({:count}, _from, :ok) do
    {:reply, :ets.info(__MODULE__, :size), :ok}
  end

  ##################################################
  # Private
  ##################################################

  defp next_id do
    case :ets.last(__MODULE__) do
      :"$end_of_table" -> 1
      last -> last + 1
    end
  end
end
