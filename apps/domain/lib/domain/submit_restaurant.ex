defmodule LunchRoulette.Business.SubmitRestaurant do
  def process(restaurant, data_store) do
    MapSet.put(data_store, restaurant)
  end
end
