defmodule LunchRoulette.Business.SubmitRestaurant do
  def process("Pizza Express", data_store) do
    MapSet.put(data_store, "Pizza Express")
  end
end
