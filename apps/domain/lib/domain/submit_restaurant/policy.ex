defmodule Domain.SubmitRestaurant.Policy do
  alias Domain.Restaurant

  def submit(nil, _save) do
    {:error, {:validation, :no_restaurant}}
  end

  def submit(%Restaurant{name: name}, _save) when name in ["", nil] do
    {:error, {:validation, :anonymous}}
  end

  def submit(%Restaurant{} = restaurant, save) do
    save.(restaurant)
  end
end
