defmodule Domain.SubmitRestaurant.Validation do
  alias Domain.Restaurant

  def validate(%Restaurant{name: ""}) do
    Result.fail({:validation, :anonymous})
  end

  def validate(%Restaurant{} = restaurant) do
    Result.succeed(restaurant)
  end
end
