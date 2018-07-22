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

  setup do
    %{irrelevant_restaurant: %Restaurant{name: Faker.Company.name()}}
  end

  test "restaurant not listed", %{irrelevant_restaurant: irrelevant_restaurant} do
    expect(Validator.Mock, :validate, fn ^irrelevant_restaurant -> {:ok, irrelevant_restaurant} end)
    expect(Shortlist.Mock, :shortlist, fn ^irrelevant_restaurant -> {:ok, irrelevant_restaurant} end)
    expect(Feedback.Mock, :report_success, fn ^irrelevant_restaurant -> :ok end)

    SubmitRestaurant.submit(irrelevant_restaurant, @config)
  end

  test "restaurant already shortlisted", %{irrelevant_restaurant: irrelevant_restaurant} do
    expect(Validator.Mock, :validate, fn ^irrelevant_restaurant -> {:ok, irrelevant_restaurant} end)
    expect(Shortlist.Mock, :shortlist, fn ^irrelevant_restaurant -> {:error, :already_shortlisted} end)
    expect(Feedback.Mock, :report_already_shortlisted, fn ^irrelevant_restaurant -> :ok end)

    SubmitRestaurant.submit(irrelevant_restaurant, @config)
  end

  test "nil submission", %{irrelevant_restaurant: irrelevant_restaurant} do
    expect(Validator.Mock, :validate, fn ^irrelevant_restaurant -> {:error, :nil_submission} end)
    expect(Feedback.Mock, :report_invalid_submission, fn :nil_submission -> :ok end)

    SubmitRestaurant.submit(irrelevant_restaurant, @config)
  end

  test "nil restaurant name", %{irrelevant_restaurant: irrelevant_restaurant} do
    expect(Validator.Mock, :validate, fn ^irrelevant_restaurant -> {:error, :nil_restaurant_name} end)
    expect(Feedback.Mock, :report_invalid_submission, fn :nil_restaurant_name -> :ok end)

    SubmitRestaurant.submit(irrelevant_restaurant, @config)
  end

  test "empty restaurant name", %{irrelevant_restaurant: irrelevant_restaurant} do
    expect(Validator.Mock, :validate, fn ^irrelevant_restaurant -> {:error, :empty_restaurant_name} end)
    expect(Feedback.Mock, :report_invalid_submission, fn :empty_restaurant_name -> :ok end)

    SubmitRestaurant.submit(irrelevant_restaurant, @config)
  end
end
