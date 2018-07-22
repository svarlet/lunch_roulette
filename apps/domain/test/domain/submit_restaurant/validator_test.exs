defmodule LunchRoulette.Business.SubmitRestaurant.ValidatorTest do
  use ExUnit.Case, async: true

  alias LunchRoulette.Business.SubmitRestaurant.Validator.SubmissionValidator

  test "nil restaurant" do
    assert {:error, :nil_submission} == SubmissionValidator.validate(nil)
  end
end
