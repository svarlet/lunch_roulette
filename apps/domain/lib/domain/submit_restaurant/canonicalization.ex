defmodule Domain.SubmitRestaurant.Canonicalization do
  alias Domain.Restaurant

  def canonicalize(nil) do
    Result.fail({:canonicalization, :not_canonicalizable})
  end

  def canonicalize(%{name: name}) do
    Result.succeed(%Restaurant{name: name})
  end

  def canonicalize(_) do
    Result.fail({:canonicalization, :missing_name})
  end
end
