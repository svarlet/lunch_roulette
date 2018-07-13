defmodule LunchRoulette.Business.SubmitRestaurantTest do
  use ExUnit.Case, async: true

  alias LunchRoulette.Business.SubmitRestaurant

  describe "given a valid and unregistered restaurant" do
    test "should persist the restaurant to the data store" do
      assert ["Pizza Express"] == SubmitRestaurant.process("Pizza Express", [])
    end

    test "should persist another restaurant to the data store" do
      assert ["Wagamama"] == SubmitRestaurant.process("Wagamama", [])
    end
  end

  describe "given a valid and registered restaurant" do
    test "should not persist the restaurant a second time" do
      assert ["Pizza Express"] == SubmitRestaurant.process("Pizza Express", ["Pizza Express"])
    end
  end

end
