defmodule LunchRoulette.Business.SubmitRestaurant do
  def process(restaurant, data_store) do
    if valid?(restaurant) do
      if registered?(data_store, restaurant) do
        data_store
      else
        Storage.store(data_store, restaurant)
      end
    else
      data_store
    end
  end

  defp registered?(data_store, restaurant) do
    Enum.member?(data_store, restaurant)
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
  def store(data_storage, data_store)
end

defimpl Storage, for: List do
  def store(data_store, restaurant) do
    [restaurant | data_store]
  end
end
