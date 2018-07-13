defmodule LunchRoulette.Business.SubmitRestaurant do
  def process(restaurant, data_store) do
    if Enum.member?(data_store, restaurant) do
      data_store
    else
      [restaurant | data_store]
    end
  end
end
