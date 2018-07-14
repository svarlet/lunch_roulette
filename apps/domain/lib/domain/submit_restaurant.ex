defmodule LunchRoulette.Business.SubmitRestaurant do
  def process(restaurant, data_store) do
    if valid?(restaurant) do
      if Storage.registered?(data_store, restaurant) do
        data_store
      else
        Storage.store(data_store, restaurant)
      end
    else
      data_store
    end
  end

  defp valid?(restaurant) do
    case restaurant do
      nil -> false
      "" -> false
      _ -> true
    end
  end
end

defprotocol Storage do
  def store(data_store, data_store)

  def registered?(data_store, restaurant)
end

defimpl Storage, for: List do
  def store(data_store, restaurant) do
    [restaurant | data_store]
  end

  def registered?(data_store, restaurant) do
    Enum.member?(data_store, restaurant)
  end
end
