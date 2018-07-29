defmodule Domain.SubmitRestaurantTest do
  use ExUnit.Case, async: true

  import Domain.SubmitRestaurant.Policy

  alias Domain.Restaurant

  test "put on the shortlist" do
    restaurant = %Restaurant{name: "Pizza Express"}
    assert Result.succeed(restaurant) == submit(restaurant, &successful_save/1)
    assert_received {:save, ^restaurant}
  end

  defp successful_save(restaurant) do
    send(self(), {:save, restaurant})
    Result.succeed(restaurant)
  end

  test "handle shortlist failure gracefully" do
    restaurant = %Restaurant{name: "Pizza Express"}
    assert Result.fail(:already_exists) == submit(restaurant, &unsuccessful_save/1)
    assert_received {:save, ^restaurant}
  end

  defp unsuccessful_save(restaurant) do
    send(self(), {:save, restaurant})
    Result.fail(:already_exists)
  end
end
