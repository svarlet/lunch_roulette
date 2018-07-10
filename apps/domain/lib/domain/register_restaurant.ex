defmodule LunchRoulette.Business.RegisterRestaurant do
  def register(_) do
    {:error, {:invalid_restaurant_name, nil}}
  end
end
