defmodule LunchRoulette.Business.SubmitRestaurantTest do
  use ExUnit.Case, async: true

  alias LunchRoulette.Business.SubmitRestaurant

  describe "given a valid and unregistered restaurant" do
    test "should persist the restaurant to the data store" do
      data_store = SubmitRestaurant.process("Pizza Express", %MapSet{})
      assert MapSet.member?(data_store, "Pizza Express")
    end

  end

end
