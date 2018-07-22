defmodule LunchRoulette.Business.SubmitRestaurantTest do
  use ExUnit.Case, async: true

  import Mox

  alias LunchRoulette.Business.Restaurant
  alias LunchRoulette.Business.SubmitRestaurant
  alias LunchRoulette.Business.SubmitRestaurant.{Validator, Shortlist, Feedback}

  setup :verify_on_exit!

  defmock(Validator.Mock, for: Validator)

  defmock(Shortlist.Mock, for: Shortlist)

  defmock(Feedback.Mock, for: Feedback)

  test "restaurant not listed" do
    restaurant = %Restaurant{name: "Pizza Express"}
    expect(Validator.Mock, :validate, fn ^restaurant -> {:ok, restaurant} end)
    expect(Shortlist.Mock, :shortlist, fn ^restaurant -> {:ok, restaurant} end)
    expect(Feedback.Mock, :report_success, fn ^restaurant -> :ok end)
    SubmitRestaurant.submit(restaurant, Validator.Mock, Shortlist.Mock, Feedback.Mock)
  end
end
