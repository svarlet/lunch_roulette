defmodule LunchRoulette.Business.Restaurant do
  defstruct [:name]
end

defmodule LunchRoulette.Business.SubmitRestaurant do
  alias LunchRoulette.Storage
  alias LunchRoulette.Business.Restaurant

  def submit(%Restaurant{name: "Pizza Express"} = restaurant, data_store) do
    Storage.save(data_store, restaurant)
  end
end

defprotocol LunchRoulette.Storage do
  def save(data_store, restaurant)
end
