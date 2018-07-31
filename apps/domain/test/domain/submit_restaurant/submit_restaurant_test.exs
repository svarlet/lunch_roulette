defmodule Domain.SubmitRestaurantTest do
  use ExUnit.Case, async: true

  import Domain.SubmitRestaurant.Policy

  alias Domain.Restaurant

  test "put on the shortlist" do
    params = %{"name" => "Pizza Express"}
    restaurant = %Restaurant{name: "Pizza Express"}
    assert {:ok, restaurant} == submit(params, &successful_save/1)
  end

  defp successful_save(restaurant) do
    {:ok, restaurant}
  end

  test "handle shortlist failure gracefully" do
    params = %{"name" => "Pizza Express"}
    assert {:error, :already_exists} == submit(params, &unsuccessful_save/1)
  end

  defp unsuccessful_save(_restaurant) do
    {:error, :already_exists}
  end
end
