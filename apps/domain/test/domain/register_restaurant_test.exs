# TODO: restaurant not registered
# TODO: restaurant already registered
# TODO: restaurant is nil
# TODO: restaurant is ""
# TODO: persistance failed
# TODO: reporting failed

defmodule LunchRoulette.Business.RegisterRestaurantWithNilNameTest do
  use ExUnit.Case, async: true

  alias LunchRoulette.Business.RegisterRestaurant

  test "returns an error" do
    persistance = fn _ -> :ok end
    presenter = fn _ -> :ok end

    assert {:error, {:invalid_restaurant_name, nil}} ==
             RegisterRestaurant.register(nil, persistance, presenter)
  end

  test "does not attempt to save the restaurant" do
    persistance = fn _ -> send(self(), :attempted_save) end
    presenter = fn _ -> :ok end
    RegisterRestaurant.register(nil, persistance, presenter)
    refute_received(:attempted_save)
  end

  test "reports the error" do
    persistance = fn _ -> :ok end
    presenter = fn error -> send(self(), error) end
    RegisterRestaurant.register(nil, persistance, presenter)
    assert_received({:error, {:invalid_restaurant_name, nil}})
  end
end

defmodule LunchRoulette.Business.RegisterRestaurantWithEmptyNameTest do
  use ExUnit.Case, async: true

  alias LunchRoulette.Business.RegisterRestaurant

  test "returns an error" do
    persistance = fn _ -> :ok end
    presenter = fn _ -> :ok end

    assert {:error, {:invalid_restaurant_name, ""}} ==
             RegisterRestaurant.register("", persistance, presenter)
  end

  test "does not attempt to save the restaurant" do
    persistance = fn _ -> send(self(), :attempted_save) end
    presenter = fn _ -> :ok end

    RegisterRestaurant.register("", persistance, presenter)

    refute_received(:attempted_save)
  end

  test "reports the error via the presenter" do
    persistance = fn _ -> :ok end
    presenter = fn error -> send(self(), error) end
    RegisterRestaurant.register("", persistance, presenter)
    assert_received({:error, {:invalid_restaurant_name, ""}})
  end
end


defmodule LunchRoulette.Business.RegisterUnregisteredRestaurantTest do
  use ExUnit.Case, async: true

  alias LunchRoulette.Business.RegisterRestaurant

  test "succeeds" do
    persistance = fn _ -> :ok end
    presenter = fn _ -> :ok end
    assert {:ok, "The unregistered restaurant"} == RegisterRestaurant.register("The unregistered restaurant", persistance, presenter)
  end

  test "succeeds with another unregistered restaurant" do
    persistance = fn _ -> :ok end
    presenter = fn _ -> :ok end
    assert {:ok, "The other unregistered restaurant"} == RegisterRestaurant.register("The other unregistered restaurant", persistance, presenter)
  end

  test "persists the restaurant" do
    persistance = fn restaurant -> send(self(), {:ok, restaurant}) end
    presenter = fn _ -> :ok end
    RegisterRestaurant.register("The unregistered restaurant", persistance, presenter)
    assert_received({:ok, "The unregistered restaurant"})
  end
end
