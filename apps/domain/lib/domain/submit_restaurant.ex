defmodule LunchRoulette.Business.Restaurant do
  defstruct [:name]
end

defmodule LunchRoulette.Business.SubmitRestaurant do
  def submit(_, _) do
  end
end

defprotocol LunchRoulette.Storage do
  def registered?(storage, restaurant)
end

defimpl LunchRoulette.Storage, for: List do
  def registered?(_, _) do
    true
  end
end
