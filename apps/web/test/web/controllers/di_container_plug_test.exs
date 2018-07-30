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

  test "call/2 nest the supplied options under conn.assigns.di_container" do
    options = %{foo: fn _ -> 12 end}
    conn = DIContainerPlug.call(%Plug.Conn{}, options)
    assert conn.assigns.di_container == options
  end
end
