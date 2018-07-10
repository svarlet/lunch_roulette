defmodule LunchRoulette.Business.RegisterRestaurant do
  def register(restaurant, _persistance, presenter) do
    error = {:error, {:invalid_restaurant_name, restaurant}}
    presenter.(error)
    error
  end
end
