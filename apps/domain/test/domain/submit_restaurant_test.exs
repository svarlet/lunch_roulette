defmodule LunchRoulette.Business.SubmitRestaurantTest do
  use ExUnit.Case, async: true

  alias LunchRoulette.Business.{Restaurant, SubmitRestaurant}
  alias LunchRoulette.Storage

  defmodule MockStorage do
    defstruct restaurants: []

    defimpl Storage do
      def save(_data_store, restaurant) do
        send(self(), {:saved, restaurant})
      end
    end
  end

  describe "given a valid and unregistered restaurant" do
    test "should persist the restaurant to the data store" do
      store = %MockStorage{}
      restaurant = %Restaurant{name: "Pizza Express"}
      SubmitRestaurant.submit(restaurant, store)
      assert_received {:saved, ^restaurant}
    end

    # test "should persist another restaurant to the data store" do
    # end
  end

  describe "given a valid and registered restaurant" do
    # test "should not persist the restaurant a second time" do
    # end
  end

  describe "given an invalid submission" do
    # test "should not persist the restaurant" do
    # end
  end
end
