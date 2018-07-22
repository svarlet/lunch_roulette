defmodule LunchRoulette.Business.SubmitRestaurant.ValidatorTest do
  use ExUnit.Case, async: true

  alias LunchRoulette.Business.Restaurant
  alias LunchRoulette.Business.SubmitRestaurant.Validator.SubmissionValidator

  test "nil restaurant" do
    assert {:error, :nil_submission} == SubmissionValidator.validate(nil)
  end

  test "empty name" do
    restaurant = %Restaurant{name: ""}
    assert {:error, :empty_restaurant_name} == SubmissionValidator.validate(restaurant)
  end
end