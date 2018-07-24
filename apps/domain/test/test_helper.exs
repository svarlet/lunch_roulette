ExUnit.start()

defmodule LunchRoulette.Business.SubmitRestaurant.Shortlist.Mock do
  alias LunchRoulette.Business.SubmitRestaurant.Shortlist

  defstruct [:put_in_result]

  defimpl Shortlist do
    def put_in(shortlist_mock, restaurant) do
      send self(), {:put_in, shortlist_mock, restaurant}
      shortlist_mock.put_in_result
    end
  end
end

defmodule LunchRoulette.Business.SubmitRestaurant.Validator.Mock do
  alias LunchRoulette.Business.SubmitRestaurant.Validator

  defstruct [:validate_result]

  defimpl Validator do
    def validate(validator, restaurant) do
      send self(), {:validate, validator, restaurant}
      validator.validate_result
    end
  end
end
