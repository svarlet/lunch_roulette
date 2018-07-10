defmodule LunchRoulette.Business.RegisterRestaurant do
  def register("The registered restaurant", _, _) do
    {:ok, "The registered restaurant"}
  end

  def register(restaurant, _persistance, presenter) do
    error = {:error, {:invalid_restaurant_name, restaurant}}
    presenter.(error)
    error
  end
end
