# DONE: restaurant not registered
# TODO: restaurant already registered
# DONE: restaurant is nil
# DONE: restaurant is ""
# TODO: persistance failed
# TODO: reporting failed

defmodule LunchRoulette.Business.RegisterRestaurantTest do
  use ExUnit.Case, async: true

  import LunchRoulette.Business.RegisterRestaurant, only: [register: 3]

  def dummy_persistance(_), do: :ok

  def persistance_spy(restaurant), do: send(self(), restaurant)

  def dummy_presenter(_), do: :ok

  def presenter_spy(report), do: send(self(), report)

  describe "register a restaurant with a nil name" do
    test "returns an error" do
      assert {:error, {:invalid_restaurant_name, nil}} ==
               register(nil, &dummy_persistance/1, &dummy_presenter/1)
    end

    test "does not attempt to save the restaurant" do
      register(nil, &persistance_spy/1, &dummy_presenter/1)
      refute_received(nil)
    end

    test "reports the error" do
      register(nil, &dummy_persistance/1, &presenter_spy/1)
      assert_received({:error, {:invalid_restaurant_name, nil}})
    end
  end

  describe "register a restaurant with an empty name" do
    test "returns an error" do
      assert {:error, {:invalid_restaurant_name, ""}} ==
               register("", &dummy_persistance/1, &dummy_presenter/1)
    end

    test "does not attempt to save the restaurant" do
      register("", &persistance_spy/1, &dummy_presenter/1)

      refute_received("")
    end

    test "reports the error via the presenter" do
      register("", &dummy_persistance/1, &presenter_spy/1)
      assert_received({:error, {:invalid_restaurant_name, ""}})
    end
  end

  describe "register an unregistered restaurant" do
    test "succeeds" do
      assert {:ok, "The unregistered restaurant"} ==
               register("The unregistered restaurant", &dummy_persistance/1, &dummy_presenter/1)
    end

    test "succeeds with another unregistered restaurant" do
      assert {:ok, "The other unregistered restaurant"} ==
               register(
                 "The other unregistered restaurant",
                 &dummy_persistance/1,
                 &dummy_presenter/1
               )
    end

    test "persists the restaurant" do
      register("The unregistered restaurant", &persistance_spy/1, &dummy_presenter/1)
      assert_received("The unregistered restaurant")
    end

    test "reports the restaurant registration" do
      register("The unregistered restaurant", &dummy_persistance/1, &presenter_spy/1)
      assert_received("The unregistered restaurant")
    end
  end

  describe "restaurant already registered" do
    test "returns an error" do
      persistance = fn _restaurant -> {:error, :already_registered} end

      assert {:error, {:already_registered, "The already registered restaurant"}} =
               register("The already registered restaurant", persistance, &dummy_presenter/1)
    end

    test "attempts to persist the restaurant" do
      persistance = fn restaurant ->
        send(self(), restaurant)
        {:error, :already_registered}
      end
      register("The already registered restaurant", persistance, &dummy_presenter/1)
      assert_received("The already registered restaurant")
    end

    test "reports the failed restaurant registration" do
      persistance = fn restaurant ->
        send(self(), restaurant)
        {:error, :already_registered}
      end
      register("The already registered restaurant", persistance, &presenter_spy/1)
      assert_received("The already registered restaurant")
    end
  end
end
