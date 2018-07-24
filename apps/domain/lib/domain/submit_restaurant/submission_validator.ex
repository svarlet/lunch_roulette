defmodule LunchRoulette.Business.SubmitRestaurant.Validator.SubmissionValidator do
  alias LunchRoulette.Business.Restaurant
  alias LunchRoulette.Business.SubmitRestaurant.Validator

  defstruct []

  defimpl Validator do
    def validate(_validator, restaurant) do
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
end
