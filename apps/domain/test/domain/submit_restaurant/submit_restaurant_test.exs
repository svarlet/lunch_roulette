defmodule Domain.SubmitRestaurantTest do
  use ExUnit.Case, async: true

  import Domain.SubmitRestaurant.Policy

  alias Domain.Restaurant

  test "rejects a nil restaurant" do
    assert {:error, {:validation, :no_restaurant}} == submit(nil)
  end

  test "reject a restaurant with no name" do
    anonymous_restaurant = %Restaurant{name: nil}
    assert {:error, {:validation, :anonymous}} == submit(anonymous_restaurant)
  end
end
