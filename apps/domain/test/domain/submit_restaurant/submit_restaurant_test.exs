defmodule Domain.SubmitRestaurantTest do
  use ExUnit.Case, async: true

  import Domain.SubmitRestaurant.Policy

  alias Domain.Restaurant

  test "put on the shortlist" do
    restaurant = %Restaurant{name: "Pizza Express"}
    assert {:ok, restaurant} == submit(restaurant, &successful_save/1)
    assert_received {:save, ^restaurant}
  end

  defp successful_save(restaurant) do
    send(self(), {:save, restaurant})
    {:ok, restaurant}
  end

  test "handle shortlist failure gracefully" do
    restaurant = %Restaurant{name: "Pizza Express"}
    assert {:error, :already_exists} == submit(restaurant, &unsuccessful_save/1)
    assert_received {:save, ^restaurant}
  end

  defp unsuccessful_save(restaurant) do
    send(self(), {:save, restaurant})
    {:error, :already_exists}
  end
end
