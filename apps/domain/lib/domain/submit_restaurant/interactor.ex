defmodule LunchRoulette.Business.Restaurant do
  @type t :: %__MODULE__{name: String.t()}
  defstruct [:name]
end

defmodule LunchRoulette.Business.SubmitRestaurant.Config do
  defstruct [:validator, :shortlist, :feedback]
end

defmodule LunchRoulette.Business.SubmitRestaurant.Interactor do
  alias LunchRoulette.Business.SubmitRestaurant.{Feedback, Validator, Shortlist}

  def submit(restaurant, config) do
    with {:ok, ^restaurant} <- Validator.validate(config.validator, restaurant),
         {:ok, _shortlist} <- Shortlist.put_in(config.shortlist, restaurant) do
      Feedback.report_success(config.feedback, restaurant)
    else
      {:error, :already_shortlisted} ->
        Feedback.report_already_shortlisted(config.feedback, restaurant)

      {:error, :nil_submission} ->
        Feedback.report_invalid_submission(config.feedback, :nil_submission)

      {:error, :nil_restaurant_name} ->
        Feedback.report_invalid_submission(config.feedback, :nil_restaurant_name)

      {:error, :empty_restaurant_name} ->
        Feedback.report_invalid_submission(config.feedback, :empty_restaurant_name)
    end
  end
end
