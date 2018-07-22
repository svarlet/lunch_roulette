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

  @config %Config{
    validator_mod: Validator.Mock,
    shortlist_mod: Shortlist.Mock,
    feedback_mod: Feedback.Mock
  }

  test "restaurant not listed" do
    restaurant = %Restaurant{name: Faker.Company.name()}

    expect(Validator.Mock, :validate, fn ^restaurant -> {:ok, restaurant} end)
    expect(Shortlist.Mock, :shortlist, fn ^restaurant -> {:ok, restaurant} end)
    expect(Feedback.Mock, :report_success, fn ^restaurant -> :ok end)

    SubmitRestaurant.submit(restaurant, @config)
  end

  test "restaurant already shortlisted" do
    restaurant = %Restaurant{name: Faker.Company.name()}

    expect(Validator.Mock, :validate, fn ^restaurant -> {:ok, restaurant} end)
    expect(Shortlist.Mock, :shortlist, fn ^restaurant -> {:error, :already_shortlisted} end)
    expect(Feedback.Mock, :report_already_shortlisted, fn ^restaurant -> :ok end)

    SubmitRestaurant.submit(restaurant, @config)
  end

  test "nil submission" do
    expect(Validator.Mock, :validate, fn nil -> {:error, :nil_submission} end)
    expect(Feedback.Mock, :report_invalid_submission, fn :nil_submission -> :ok end)

    SubmitRestaurant.submit(nil, @config)
  end

  test "nil restaurant name" do
    restaurant = %Restaurant{name: nil}

    expect(Validator.Mock, :validate, fn ^restaurant -> {:error, :nil_restaurant_name} end)
    expect(Feedback.Mock, :report_invalid_submission, fn :nil_restaurant_name -> :ok end)

    SubmitRestaurant.submit(restaurant, @config)
  end

  test "empty restaurant name" do
    restaurant = %Restaurant{name: ""}

    expect(Validator.Mock, :validate, fn ^restaurant -> {:error, :empty_restaurant_name} end)
    expect(Feedback.Mock, :report_invalid_submission, fn :empty_restaurant_name -> :ok end)

    SubmitRestaurant.submit(restaurant, @config)
  end
end
