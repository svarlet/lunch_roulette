# TODO: restaurant not registered
# TODO: restaurant already registered
# TODO: restaurant is nil
# TODO: restaurant is ""

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
    assert {:ok, "The registered restaurant"} == RegisterRestaurant.register("The registered restaurant", persistance, presenter)
  end
end
