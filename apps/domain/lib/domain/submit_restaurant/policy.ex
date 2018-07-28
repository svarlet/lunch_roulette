defmodule Domain.SubmitRestaurant.Policy do
  alias Domain.Restaurant

  def submit(nil) do
    {:error, {:validation, :no_restaurant}}
  end

  def submit(%Restaurant{name: nil}) do
    {:error, {:validation, :anonymous}}
  end
end
