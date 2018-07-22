defmodule LunchRoulette.Business.SubmitRestaurantTest do
  use ExUnit.Case, async: true

  import Mox

  alias LunchRoulette.Business.Restaurant
  alias LunchRoulette.Business.SubmitRestaurant.Validator
  alias LunchRoulette.Business.SubmitRestaurant.Shortlist
  alias LunchRoulette.Business.SubmitRestaurant.Feedback
  alias LunchRoulette.Business.SubmitRestaurant

  setup :verify_on_exit!

  defmock LunchRoulette.Business.SubmitRestaurant.Validator.Mock,
    for: LunchRoulette.Business.SubmitRestaurant.Validator

  defmock LunchRoulette.Business.SubmitRestaurant.Shortlist.Mock,
    for: LunchRoulette.Business.SubmitRestaurant.Shortlist

  defmock LunchRoulette.Business.SubmitRestaurant.Feedback.Mock,
    for: LunchRoulette.Business.SubmitRestaurant.Feedback

  test "restaurant not listed" do
    restaurant = %Restaurant{name: "Pizza Express"}
    expect(Validator.Mock, :validate, fn ^restaurant -> {:ok, restaurant} end)
    expect(Shortlist.Mock, :shortlist, fn ^restaurant -> {:ok, restaurant} end)
    expect(Feedback.Mock, :report_success, fn ^restaurant -> :ok end)
    SubmitRestaurant.submit(restaurant, Validator.Mock, Shortlist.Mock, Feedback.Mock)
  end
end
