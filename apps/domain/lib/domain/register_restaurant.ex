defmodule LunchRoulette.Business.RegisterRestaurant do
  def register(restaurant, _, presenter) when restaurant in [nil, ""] do
    error = {:error, {:invalid_restaurant_name, restaurant}}
    presenter.(error)
    error
  end

  def register(restaurant, persistance, presenter) do
    persistance.(restaurant)
    presenter.(restaurant)
    {:ok, restaurant}
  end
end
