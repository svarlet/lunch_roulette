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

  test "put 2 restaurants" do
    restaurants =
      ["The foo bar", "The foo baz"]
      |> Enum.map(& %Restaurant{name: &1})

    Enum.each(restaurants, &Storage.put/1)

    Enum.each(restaurants, fn restaurant ->
      assert Storage.shortlisted?(restaurant)
    end)
  end

  test "put a shortlisted restaurant" do
    restaurant = %Restaurant{name: "Pizza Hut"}
    Storage.put(restaurant)
    assert {:error, :already_exists} == Storage.put(restaurant)
  end
end
