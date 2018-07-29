defmodule Web.Storage do
  use Agent

  def start_link() do
    Agent.start_link(fn -> MapSet.new() end, name: __MODULE__)
  end

  def put(restaurant) do
    Agent.get_and_update(__MODULE__, fn state ->
      new_state = MapSet.put(state, restaurant)
      {{:ok, restaurant}, new_state}
    end)
  end
end
