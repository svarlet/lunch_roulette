defmodule LunchRoulette.Business.Restaurant do
  @type t :: %__MODULE__{name: String.t()}
  defstruct [:name]
end

defmodule LunchRoulette.Business.SubmitRestaurant do
  alias LunchRoulette.Business.Restaurant

  defmodule Validator do
    @callback validate(Restaurant.t()) :: {:ok, Restaurant.t()}
  end

  defmodule Shortlist do
    @callback shortlist(Restaurant.t()) :: {:ok, Restaurant.t()}
  end

  defmodule Feedback do
    @callback report_success(Restaurant.t()) :: no_return
  end

  def submit(restaurant, validator_mod, shortlist_mod, feedback_mod) do
    with {:ok, ^restaurant} <- validator_mod.validate(restaurant),
         {:ok, ^restaurant} <- shortlist_mod.shortlist(restaurant) do
      feedback_mod.report_success(restaurant)
    end
  end
end
