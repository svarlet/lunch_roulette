defmodule Web.StorageTest do
  use ExUnit.Case, async: false

  alias Web.Storage
  alias Domain.Restaurant

  test "put a restaurant" do
    Storage.start_link()
    restaurant = %Restaurant{name: "Burger King"}
    assert {:ok, restaurant} == Storage.put(restaurant)
  end
end
