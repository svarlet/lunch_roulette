defmodule Domain.SubmitRestaurant.Canonicalization do
  alias Domain.Restaurant

  def canonicalize(nil) do
    {:error, {:canonicalization, :not_canonicalizable}}
  end

  def canonicalize(%{"name" => name}) do
    {:ok, %Restaurant{name: name}}
  end

  def canonicalize(_) do
    {:error, {:canonicalization, :missing_name}}
  end
end
