defmodule Domain.SubmitRestaurant.Policy do
  alias Domain.SubmitRestaurant.{Canonicalization, Validation}

  def submit(params, save) do
    with {:ok, restaurant} <- Canonicalization.canonicalize(params),
         {:ok, restaurant} <- Validation.validate(restaurant) do
      save.(restaurant)
    end
  end
end
