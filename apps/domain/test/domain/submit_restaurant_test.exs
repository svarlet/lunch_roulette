defmodule LunchRoulette.Business.SubmitRestaurantTest do
  use ExUnit.Case, async: true

  alias LunchRoulette.Business.SubmitRestaurant

  describe "given a valid and unregistered restaurant" do
    test "should persist the restaurant to the data store" do
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
