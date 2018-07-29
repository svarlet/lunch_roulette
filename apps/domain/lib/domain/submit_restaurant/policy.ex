defmodule Domain.SubmitRestaurant.Policy do
  alias Domain.SubmitRestaurant.{Canonicalization, Validation}
  alias Result

  @type restaurant_saver :: (Restaurant.t -> Result.t)

  @spec submit(Restaurant.t, restaurant_saver) :: Result.t
  def submit(restaurant, save) do
    restaurant
    |> Canonicalization.canonicalize()
    |> Result.bind(&Validation.validate/1)
    |> Result.bind(save)
  end
end
