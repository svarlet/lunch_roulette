defmodule Domain.SubmitRestaurant.Policy do
  alias Domain.Restaurant

  def submit(nil) do
    {:error, {:validation, :no_restaurant}}
  end

  def submit(%Restaurant{name: name}) when name in ["", nil] do
    {:error, {:validation, :anonymous}}
  end
end
