defmodule LunchRoulette.Business.RegisterRestaurantTest do
  use ExUnit.Case, async: true

  alias LunchRoulette.Business.RegisterRestaurant

  # TODO: restaurant not registered
  # TODO: restaurant already registered
  # TODO: restaurant is nil
  # TODO: restaurant is ""

  test "restaurant is nil" do
    assert {:error, {:invalid_restaurant_name, nil}} == RegisterRestaurant.register(nil)
  end

end
