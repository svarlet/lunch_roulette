defmodule Web.StorageTest do
  use ExUnit.Case, async: false

  alias Web.Storage
  alias Domain.Restaurant

  setup_all do
    Storage.start_link()
    :ok
  end

  test "put a restaurant" do
    restaurant = %Restaurant{name: "Burger King"}
    assert {:ok, restaurant} == Storage.put(restaurant)
  end

  test "put a shortlisted restaurant" do
    restaurant = %Restaurant{name: "Pizza Hut"}
    Storage.put(restaurant)
    assert {:error, :already_exists} == Storage.put(restaurant)
  end
end
