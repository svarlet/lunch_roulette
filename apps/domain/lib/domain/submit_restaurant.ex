defmodule LunchRoulette.Business.Restaurant do
  @type t :: %__MODULE__{name: String.t()}
  defstruct [:name]
end

defmodule LunchRoulette.Business.SubmitRestaurant.Validator do
  alias LunchRoulette.Business.Restaurant

  @callback validate(Restaurant.t) :: {:ok, Restaurant.t}
end

defmodule LunchRoulette.Business.SubmitRestaurant.Shortlist do
  alias LunchRoulette.Business.Restaurant

  @callback shortlist(Restaurant.t) :: {:ok, Restaurant.t}
end

defmodule LunchRoulette.Business.SubmitRestaurant.Feedback do
  alias LunchRoulette.Business.Restaurant

  @callback report_success(Restaurant.t) :: no_return
end

defmodule LunchRoulette.Business.SubmitRestaurant do
  def submit(restaurant, validator_mod, shortlist_mod, feedback_mod) do
    with {:ok, ^restaurant} <- validator_mod.validate(restaurant),
         {:ok, ^restaurant} <- shortlist_mod.shortlist(restaurant) do
      feedback_mod.report_success(restaurant)
    end
  end
end
