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

  defmodule Config do
    defstruct [:validator_mod, :shortlist_mod, :feedback_mod]
  end

  def submit(restaurant, config) do
    with {:ok, ^restaurant} <- config.validator_mod.validate(restaurant),
         {:ok, ^restaurant} <- config.shortlist_mod.shortlist(restaurant) do
      config.feedback_mod.report_success(restaurant)
    end
  end
end
