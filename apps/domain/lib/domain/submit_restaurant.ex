defmodule LunchRoulette.Business.SubmitRestaurant do
  def process("Pizza Express", data_store) do
    MapSet.put(data_store, "Pizza Express")
  end

  def process("Wagamama", data_store) do
    MapSet.put(data_store, "Wagamama")
  end
end
