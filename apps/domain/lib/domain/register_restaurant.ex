defmodule LunchRoulette.Business.RegisterRestaurant do
  def register(restaurant) do
    {:error, {:invalid_restaurant_name, restaurant}}
  end
end
