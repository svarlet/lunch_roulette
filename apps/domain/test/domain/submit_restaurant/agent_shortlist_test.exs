defmodule Domain.SubmitRestaurant.AgentShortlistTest do
  use ExUnit.Case, async: true

  alias Domain.Restaurant
  alias Domain.SubmitRestaurant.{Shortlist, AgentShortlist}

  test "put_in 1 restaurant" do
    {:ok, pid} = Agent.start_link(fn -> MapSet.new() end)
    shortlist = %AgentShortlist{pid: pid}
    restaurant = %Restaurant{name: Faker.Company.name()}
    assert {:ok, shortlist} == Shortlist.put_in(shortlist, restaurant)
    assert Agent.get(shortlist.pid, fn mapset -> MapSet.member?(mapset, restaurant) end)
  end

  test "put_in 3 restaurants" do
    {:ok, pid} = Agent.start_link(fn -> MapSet.new() end)
    shortlist = %AgentShortlist{pid: pid}
    restaurants = create_few_restaurants()

    Enum.each(restaurants, &Shortlist.put_in(shortlist, &1))

    assert MapSet.new(restaurants) == Agent.get(shortlist.pid, &(&1))
  end

  defp create_few_restaurants() do
    1..3
    |> Enum.map(fn unique_name -> "restaurant_#{unique_name}" end)
    |> Enum.map(fn name -> %Restaurant{name: name} end)
  end
end
