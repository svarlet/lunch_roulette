defmodule Domain.SubmitRestaurant.AgentShortlist do
  alias Domain.SubmitRestaurant.Shortlist

  defstruct [:pid]

  defimpl Shortlist do
    alias Domain.SubmitRestaurant.AgentShortlist

    def put_in(%AgentShortlist{pid: pid} = shortlist, restaurant) do
      Agent.get_and_update(pid, fn mapset ->
        if MapSet.member?(mapset, restaurant) do
          {{:error, :already_shortlisted}, mapset}
        else
          updated_mapset = MapSet.put(mapset, restaurant)
          {{:ok, shortlist}, updated_mapset}
        end
      end)
    end
  end
end
