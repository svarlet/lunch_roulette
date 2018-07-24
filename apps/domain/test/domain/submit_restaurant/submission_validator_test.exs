defmodule Domain.SubmitRestaurant.Validator.SubmissionValidatorTest do
  use ExUnit.Case, async: true

  alias Domain.Restaurant
  alias Domain.SubmitRestaurant.Validator
  alias Domain.SubmitRestaurant.Validator.SubmissionValidator

  @validator %SubmissionValidator{}

  test "nil restaurant" do
    assert {:error, :nil_submission} == Validator.validate(@validator, nil)
  end

  test "empty name" do
    restaurant = %Restaurant{name: ""}
    assert {:error, :empty_restaurant_name} == Validator.validate(@validator, restaurant)
  end

  test "nil restaurant name" do
    restaurant = %Restaurant{name: nil}
    assert {:error, :nil_restaurant_name} == Validator.validate(@validator, restaurant)
  end

  test "valid restaurant" do
    restaurant = %Restaurant{name: Faker.Company.name()}
    assert {:ok, restaurant} == Validator.validate(@validator, restaurant)
  end
end
