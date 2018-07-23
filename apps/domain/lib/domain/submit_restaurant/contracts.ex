defmodule LunchRoulette.Business.SubmitRestaurant.Validator do
  alias LunchRoulette.Business.Restaurant

  @type result ::
          {:ok, Restaurant.t()}
          | {:error, :nil_submission}
          | {:error, :nil_restaurant_name}
          | {:error, :empty_restaurant_name}

  @callback validate(Restaurant.t()) :: result
end

defprotocol LunchRoulette.Business.SubmitRestaurant.Shortlist do
  alias LunchRoulette.Business.Restaurant

  @type shortlist :: any
  @type result :: {:ok, shortlist} | {:error, :already_shortlisted}

  @spec put_in(shortlist, Restaurant.t()) :: result
  def put_in(shortlist, restaurant)
end

defmodule LunchRoulette.Business.SubmitRestaurant.Feedback do
  alias LunchRoulette.Business.Restaurant

  @callback report_success(Restaurant.t()) :: no_return

  @callback report_already_shortlisted(Restaurant.t()) :: no_return

  @callback report_invalid_submission(Restaurant.t()) :: no_return
end
