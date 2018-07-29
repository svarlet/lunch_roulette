defmodule Domain.SubmitRestaurant.ValidationTest do
  use ExUnit.Case, async: true

  import Domain.SubmitRestaurant.Validation

  alias Domain.Restaurant

  test "reject a restaurant with an empty name" do
    anonymous_restaurant = %Restaurant{name: ""}
    assert {:error, {:validation, :anonymous}} == validate(anonymous_restaurant)
  end

  test "accept a restaurant with a non empty name" do
    named_restaurant = %Restaurant{name: "Pizza Express"}
    assert {:ok, named_restaurant} == validate(named_restaurant)
  end
end
