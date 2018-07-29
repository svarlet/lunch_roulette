defmodule Domain.SubmitRestaurant.Policy do
  alias Domain.SubmitRestaurant.{Canonicalization, Validation}
  alias Result

  def submit(restaurant, save) do
    restaurant
    |> Canonicalization.canonicalize()
    |> Result.bind(&Validation.validate/1)
    |> Result.bind(save)
  end
end
