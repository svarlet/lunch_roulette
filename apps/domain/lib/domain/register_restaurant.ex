defmodule LunchRoulette.Business.RegisterRestaurant do
  def register(restaurant, _persistance) do
    {:error, {:invalid_restaurant_name, restaurant}}
  end
end
