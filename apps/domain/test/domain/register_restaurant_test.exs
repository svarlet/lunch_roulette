# TODO: restaurant not registered
# TODO: restaurant already registered
# TODO: restaurant is nil
# TODO: restaurant is ""

defmodule LunchRoulette.Business.RegisterRestaurantWithNilNameTest do
  use ExUnit.Case, async: true

  alias LunchRoulette.Business.RegisterRestaurant

  test "returns an error" do
    persistance = fn _ -> :ok end
    assert {:error, {:invalid_restaurant_name, nil}} == RegisterRestaurant.register(nil, persistance)
  end

  test "does not attempt to save the restaurant" do
    persistance = fn _ -> send(self(), :attempted_save) end
    RegisterRestaurant.register(nil, persistance)
    refute_received(:attempted_save)
  end
end


# defmodule LunchRoulette.Business.RegisterRestaurantWithEmptyNameTest do
#   use ExUnit.Case, async: true

#   alias LunchRoulette.Business.RegisterRestaurant

#   test "returns an error" do
#     assert {:error, {:invalid_restaurant_name, ""}} == RegisterRestaurant.register("")
#   end
# end
