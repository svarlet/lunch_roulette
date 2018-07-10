defmodule LunchRoulette.Business.RegisterRestaurantTest do
  use ExUnit.Case, async: true

  alias LunchRoulette.Business.RegisterRestaurant

  test "restaurant exists" do
    store = fn restaurant -> send self(), restaurant end
    RegisterRestaurant.register_restaurant("already_registered", store)
    refute_received "already registered restaurant"
  end

  test "restaurant does not exist"

  test "nil"

  test "empty name"


end
