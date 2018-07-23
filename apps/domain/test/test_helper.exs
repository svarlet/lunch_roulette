ExUnit.start()

defmodule LunchRoulette.Business.SubmitRestaurant.Shortlist.Mock do
  alias LunchRoulette.Business.SubmitRestaurant.Shortlist

  defstruct restaurants: [],
    put_in_result: nil

  defimpl Shortlist do
    def put_in(shortlist_mock, restaurant) do
      send self(), {:put_in, shortlist_mock, restaurant}
      shortlist_mock.put_in_result
    end
  end
end
