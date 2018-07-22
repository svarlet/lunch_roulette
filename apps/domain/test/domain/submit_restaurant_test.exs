defmodule LunchRoulette.Business.SubmitRestaurantTest do
  use ExUnit.Case, async: true

  import Mox

  alias LunchRoulette.Business.Restaurant
  alias LunchRoulette.Business.SubmitRestaurant
  alias LunchRoulette.Business.SubmitRestaurant.{Validator, Shortlist, Feedback, Config}

  setup :verify_on_exit!

  defmock(Validator.Mock, for: Validator)

  defmock(Shortlist.Mock, for: Shortlist)

  defmock(Feedback.Mock, for: Feedback)

  test "restaurant not listed" do
    restaurant = %Restaurant{name: Faker.Company.name()}

    config = %Config{
      validator_mod: Validator.Mock,
      shortlist_mod: Shortlist.Mock,
      feedback_mod: Feedback.Mock
    }

    expect(Validator.Mock, :validate, fn ^restaurant -> {:ok, restaurant} end)
    expect(Shortlist.Mock, :shortlist, fn ^restaurant -> {:ok, restaurant} end)
    expect(Feedback.Mock, :report_success, fn ^restaurant -> :ok end)

    SubmitRestaurant.submit(restaurant, config)
  end

  test "restaurant already shortlisted" do
    restaurant = %Restaurant{name: Faker.Company.name()}

    config = %Config{
      validator_mod: Validator.Mock,
      shortlist_mod: Shortlist.Mock,
      feedback_mod: Feedback.Mock
    }

    expect(Validator.Mock, :validate, fn ^restaurant -> {:ok, restaurant} end)
    expect(Shortlist.Mock, :shortlist, fn ^restaurant -> {:error, :already_shortlisted} end)
    expect(Feedback.Mock, :report_already_shortlisted, fn ^restaurant -> :ok end)

    SubmitRestaurant.submit(restaurant, config)
  end
end
