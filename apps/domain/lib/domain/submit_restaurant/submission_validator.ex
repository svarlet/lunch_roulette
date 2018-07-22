defmodule LunchRoulette.Business.SubmitRestaurant.Validator.SubmissionValidator do
  @behaviour LunchRoulette.Business.SubmitRestaurant.Validator

  alias LunchRoulette.Business.Restaurant

  def validate(restaurant) do
    case restaurant do
      nil ->
        {:error, :nil_submission}

      %Restaurant{name: ""} ->
        {:error, :empty_restaurant_name}

      %Restaurant{name: nil} ->
        {:error, :nil_restaurant_name}

      %Restaurant{} = restaurant ->
        {:ok, restaurant}
    end
  end
end
