defmodule LunchRoulette.Business.Restaurant do
  @type t :: %__MODULE__{name: String.t()}
  defstruct [:name]
end

defmodule LunchRoulette.Business.SubmitRestaurant.Config do
  defstruct [:validator, :shortlist, :feedback_mod]
end

defmodule LunchRoulette.Business.SubmitRestaurant.Interactor do
  alias LunchRoulette.Business.SubmitRestaurant.{Validator, Shortlist}

  def submit(restaurant, config) do
    with {:ok, ^restaurant} <- Validator.validate(config.validator, restaurant),
         {:ok, _shortlist} <- Shortlist.put_in(config.shortlist, restaurant) do
      config.feedback_mod.report_success(restaurant)
    else
      {:error, :already_shortlisted} ->
        config.feedback_mod.report_already_shortlisted(restaurant)

      {:error, :nil_submission} ->
        config.feedback_mod.report_invalid_submission(:nil_submission)

      {:error, :nil_restaurant_name} ->
        config.feedback_mod.report_invalid_submission(:nil_restaurant_name)

      {:error, :empty_restaurant_name} ->
        config.feedback_mod.report_invalid_submission(:empty_restaurant_name)
    end
  end
end
