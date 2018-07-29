defmodule Domain.SubmitRestaurant.CanonicalizationTest do
  use ExUnit.Case, async: true

  import Domain.SubmitRestaurant.Canonicalization

  alias Domain.Restaurant

  test "rejects a datastructure without a name key" do
    assert {:error, {:canonicalization, :missing_name}} == canonicalize(%{})
    assert {:error, {:canonicalization, :missing_name}} == canonicalize(%{foo: "bar"})
  end

  test "rejects a nil datastructure" do
    assert {:error, {:canonicalization, :not_canonicalizable}} == canonicalize(nil)
  end

  test "accepts a datastructure with a name property" do
    ds = %{name: "a name"}
    assert {:ok, %Restaurant{name: "a name"}} == canonicalize(ds)
  end
end
