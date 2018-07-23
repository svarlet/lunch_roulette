defmodule LunchRoulette.Business.Restaurant do
  @type t :: %__MODULE__{name: String.t()}
  defstruct [:name]
end

defmodule LunchRoulette.Business.SubmitRestaurant do
  alias LunchRoulette.Business.Restaurant

  defmodule Validator do
    @type result ::
            {:ok, Restaurant.t()}
            | {:error, :nil_submission}
            | {:error, :nil_restaurant_name}
            | {:error, :empty_restaurant_name}

    @callback validate(Restaurant.t()) :: result
  end

  defprotocol Shortlist do
    @type shortlist :: any
    @type result :: {:ok, shortlist} | {:error, :already_shortlisted}

    @spec put_in(shortlist, Restaurant.t()) :: result
    def put_in(shortlist, restaurant)
  end

  defmodule Feedback do
    @callback report_success(Restaurant.t()) :: no_return

    @callback report_already_shortlisted(Restaurant.t()) :: no_return

    @callback report_invalid_submission(Restaurant.t()) :: no_return
  end

  defmodule Config do
    defstruct [:validator_mod, :shortlist, :feedback_mod]
  end

  defmodule Interactor do
    def submit(restaurant, config) do
      with {:ok, ^restaurant} <- config.validator_mod.validate(restaurant),
           {:ok, _shortlist} <- Shortlist.put_in(config.shortlist, restaurant) do
           # {:ok, ^restaurant} <- config.shortlist_mod.shortlist(restaurant) do
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
end
