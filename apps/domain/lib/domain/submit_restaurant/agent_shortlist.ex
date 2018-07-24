defmodule Domain.SubmitRestaurant.AgentShortlist do
  alias Domain.SubmitRestaurant.Shortlist

  defstruct [:pid]

  defimpl Shortlist do
    alias Domain.SubmitRestaurant.AgentShortlist

    def put_in(%AgentShortlist{pid: pid} = shortlist, restaurant) do
      Agent.update(pid, fn mapset -> MapSet.put(mapset, restaurant) end)
      {:ok, shortlist}
    end
  end
end
