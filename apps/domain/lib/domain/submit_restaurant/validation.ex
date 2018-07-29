defmodule Domain.SubmitRestaurant.Validation do
  alias Domain.Restaurant

  def validate(%Restaurant{name: ""}) do
    {:error, {:validation, :anonymous}}
  end

  def validate(%Restaurant{} = restaurant) do
    {:ok, restaurant}
  end
end
