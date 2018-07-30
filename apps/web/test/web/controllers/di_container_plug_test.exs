defmodule Web.DIContainerPlugTest do
  use ExUnit.Case, async: true

  alias Web.DIContainerPlug

  test "init/1 is the identity function" do
    assert %{foo: "bar"} == DIContainerPlug.init(%{foo: "bar"})
  end

  test "init/1 raises a FunctionClauseError when option is not a map" do
    assert_raise(FunctionClauseError, fn ->
      DIContainerPlug.init(42)
    end)
  end

  # init only accepts maps
  # call sets conn.assigns
end
