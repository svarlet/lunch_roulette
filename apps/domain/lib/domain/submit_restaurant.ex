defmodule LunchRoulette.Business.SubmitRestaurant do
  def process(restaurant, data_store) do
    if registered?(data_store, restaurant) do
      data_store
    else
      store(restaurant, data_store)
    end
  end

  defp registered?(data_store, restaurant) do
    Enum.member?(data_store, restaurant)
  end

  defp store(restaurant, data_store) do
    [restaurant | data_store]
  end
end
