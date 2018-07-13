defmodule LunchRoulette.Business.SubmitRestaurant do
  def process(restaurant, data_store) do
    [restaurant | data_store]
  end
end
