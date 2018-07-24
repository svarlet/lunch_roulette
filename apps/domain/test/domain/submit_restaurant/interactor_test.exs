defmodule LunchRoulette.Business.SubmitRestaurant.InteractorTest do
  use ExUnit.Case, async: true

  alias LunchRoulette.Business.Restaurant
  alias LunchRoulette.Business.SubmitRestaurant.{Shortlist, Interactor, Validator, Feedback, Config}

  @config %Config{
    validator: %Validator.Mock{},
    shortlist: %Shortlist.Mock{},
    feedback: %Feedback.Mock{}
  }

  defp with_shortlist_mock(config, canned_result) do
    shortlist = %Shortlist.Mock{put_in_result: canned_result}
    %Config{config | shortlist: shortlist}
  end

  defp with_validator_mock(config, canned_result) do
    validator = %Validator.Mock{validate_result: canned_result}
    %Config{config | validator: validator}
  end

  setup do
    %{a_restaurant: %Restaurant{name: Faker.Company.name()}}
  end

  test "restaurant not listed", %{a_restaurant: a_restaurant} do
    config =
      @config
      |> with_shortlist_mock({:ok, @config.shortlist})
      |> with_validator_mock({:ok, a_restaurant})

    Interactor.submit(a_restaurant, config)

    assert_received {:put_in, shortlist, ^a_restaurant}
    assert shortlist == config.shortlist
    assert_received {:validate, validator, ^a_restaurant}
    assert validator == config.validator
    assert_received {:report_success, feedback, ^a_restaurant}
    assert feedback == config.feedback
  end

  test "restaurant already shortlisted", %{a_restaurant: a_restaurant} do
    config =
      @config
      |> with_shortlist_mock({:error, :already_shortlisted})
      |> with_validator_mock({:ok, a_restaurant})

    Interactor.submit(a_restaurant, config)

    assert_received {:put_in, shortlist, ^a_restaurant}
    assert shortlist == config.shortlist
    assert_received {:validate, validator, ^a_restaurant}
    assert validator == config.validator
    assert_received {:report_already_shortlisted, feedback, ^a_restaurant}
    assert feedback == config.feedback
  end

  test "nil submission", %{a_restaurant: a_restaurant} do
    config =
      @config
      |> with_validator_mock({:error, :nil_submission})

    Interactor.submit(a_restaurant, config)

    assert_received {:validate, validator, ^a_restaurant}
    assert validator == config.validator
    assert_received {:report_invalid_submission, feedback, :nil_submission}
    assert feedback == config.feedback
  end

  test "nil restaurant name", %{a_restaurant: a_restaurant} do
    config =
      @config
      |> with_validator_mock({:error, :nil_restaurant_name})

    Interactor.submit(a_restaurant, config)

    assert_received {:validate, validator, ^a_restaurant}
    assert validator == config.validator
    assert_received {:report_invalid_submission, feedback, :nil_restaurant_name}
    assert feedback == config.feedback
  end

  test "empty restaurant name", %{a_restaurant: a_restaurant} do
    config =
      @config
      |> with_validator_mock({:error, :empty_restaurant_name})

    Interactor.submit(a_restaurant, config)

    assert_received {:validate, validator, ^a_restaurant}
    assert validator == config.validator
    assert_received {:report_invalid_submission, feedback, :empty_restaurant_name}
    assert feedback == config.feedback
  end
end
