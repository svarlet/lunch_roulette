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
end
