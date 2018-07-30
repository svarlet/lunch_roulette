defmodule Web.DIContainerPlugTest do
  use ExUnit.Case, async: true

  alias Web.DIContainerPlug

  test "init/1 is the identity function" do
    assert %{foo: "bar"} == DIContainerPlug.init(%{foo: "bar"})
  end

  # init only accepts maps
  # call sets conn.assigns
end
