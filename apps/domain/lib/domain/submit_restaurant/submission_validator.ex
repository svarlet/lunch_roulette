defmodule LunchRoulette.Business.SubmitRestaurant.Validator.SubmissionValidator do
  @behaviour LunchRoulette.Business.SubmitRestaurant.Validator

  alias LunchRoulette.Business.Restaurant

  def validate(nil) do
    {:error, :nil_submission}
  end

  def validate(%Restaurant{name: ""}) do
    {:error, :empty_restaurant_name}
  end

  def validate(%Restaurant{name: nil}) do
    {:error, :nil_restaurant_name}
  end
end
