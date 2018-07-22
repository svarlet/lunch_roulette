defmodule LunchRoulette.Business.SubmitRestaurant.Validator.SubmissionValidator do
  @behaviour LunchRoulette.Business.SubmitRestaurant.Validator

  def validate(nil) do
    {:error, :nil_submission}
  end
end
