defmodule LunchRoulette.Business.SubmitRestaurant.InteractorTest do
  use ExUnit.Case, async: true

  import Mox

  alias LunchRoulette.Business.Restaurant
  alias LunchRoulette.Business.SubmitRestaurant.{Shortlist, Interactor, Validator, Feedback, Config}

  setup :verify_on_exit!

  defmock(Validator.Mock, for: Validator)

  defmock(Feedback.Mock, for: Feedback)

  @config %Config{
    validator_mod: Validator.Mock,
    shortlist: %Shortlist.Mock{},
    feedback_mod: Feedback.Mock
  }

  defp with_shortlist_mock(config, canned_result) do
    shortlist = %Shortlist.Mock{put_in_result: canned_result}
    %Config{config | shortlist: shortlist}
  end

  setup do
    %{a_restaurant: %Restaurant{name: Faker.Company.name()}}
  end

  test "restaurant not listed", %{a_restaurant: a_restaurant} do
    config = with_shortlist_mock(@config, {:ok, @config.shortlist})
    expect(Validator.Mock, :validate, fn ^a_restaurant -> {:ok, a_restaurant} end)
    expect(Feedback.Mock, :report_success, fn ^a_restaurant -> :ok end)

    Interactor.submit(a_restaurant, config)

    assert_received {:put_in, shortlist, ^a_restaurant}
    assert shortlist == config.shortlist
  end

  test "restaurant already shortlisted", %{a_restaurant: a_restaurant} do
    config = with_shortlist_mock(@config, {:error, :already_shortlisted})
    expect(Validator.Mock, :validate, fn ^a_restaurant -> {:ok, a_restaurant} end)
    expect(Feedback.Mock, :report_already_shortlisted, fn ^a_restaurant -> :ok end)

    Interactor.submit(a_restaurant, config)

    assert_received {:put_in, shortlist, ^a_restaurant}
    assert shortlist == config.shortlist
  end

  test "nil submission", %{a_restaurant: a_restaurant} do
    expect(Validator.Mock, :validate, fn ^a_restaurant -> {:error, :nil_submission} end)
    expect(Feedback.Mock, :report_invalid_submission, fn :nil_submission -> :ok end)

    Interactor.submit(a_restaurant, @config)
  end

  test "nil restaurant name", %{a_restaurant: a_restaurant} do
    expect(Validator.Mock, :validate, fn ^a_restaurant -> {:error, :nil_restaurant_name} end)
    expect(Feedback.Mock, :report_invalid_submission, fn :nil_restaurant_name -> :ok end)

    Interactor.submit(a_restaurant, @config)
  end

  test "empty restaurant name", %{a_restaurant: a_restaurant} do
    expect(Validator.Mock, :validate, fn ^a_restaurant -> {:error, :empty_restaurant_name} end)
    expect(Feedback.Mock, :report_invalid_submission, fn :empty_restaurant_name -> :ok end)

    Interactor.submit(a_restaurant, @config)
  end
end
