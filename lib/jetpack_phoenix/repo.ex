defmodule JetpackPhoenix.Repo do
  use GenServer

  ## Client API

  @doc """
  Starts the registry.
  """
  def start_link do
    GenServer.start_link(__MODULE__, :ok , %{})
  end

  def lookup(server, user_id) do
    GenServer.call(server, { :lookup, user_id })
  end

  def create(server, user_id) do
    GenServer.cast(server, { :create, user_id })
  end

  ## Server Callbacks
  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:lookup, user_id}, _from, tokens) do
    {:reply, Map.fetch(tokens, user_id), tokens}
  end

  def handle_call({:create, user_id}, _from, tokens) do

  end

end
