defmodule Domain.SubmitRestaurant.Policy do
  def submit(nil) do
    {:error, {:validation, :no_restaurant}}
  end
end
