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

  test "restaurant name is the empty string" do
    assert {:error, {:invalid_restaurant_name, ""}} == RegisterRestaurant.register("")
  end

end
