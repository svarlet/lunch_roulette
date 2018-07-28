defmodule Domain.SubmitRestaurantTest do
  use ExUnit.Case, async: true

  import Domain.SubmitRestaurant.Policy

  alias Domain.Restaurant

  defp unexpected_save(_), do: raise :unexpected_save

  test "rejects a nil restaurant" do
    assert {:error, {:validation, :no_restaurant}} == submit(nil, &unexpected_save/1)
  end

  test "reject a restaurant with no name" do
    anonymous_restaurant = %Restaurant{name: nil}
    assert {:error, {:validation, :anonymous}} == submit(anonymous_restaurant, &unexpected_save/1)
  end

  test "reject a restaurant with an empty name" do
    anonymous_restaurant = %Restaurant{name: ""}
    assert {:error, {:validation, :anonymous}} == submit(anonymous_restaurant, &unexpected_save/1)
  end
end
