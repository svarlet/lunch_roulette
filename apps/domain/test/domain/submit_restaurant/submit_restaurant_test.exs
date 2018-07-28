defmodule Domain.SubmitRestaurantTest do
  use ExUnit.Case, async: true

  import Domain.SubmitRestaurant.Policy

  test "rejects a nil restaurant" do
    assert {:error, {:validation, :no_restaurant}} == submit(nil)
  end
end
