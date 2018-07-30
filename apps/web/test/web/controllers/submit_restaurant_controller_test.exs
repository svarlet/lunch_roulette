defmodule Web.SubmitRestaurantControllerTest do
  use ExUnit.Case, async: true

  test "set http status to 200" do
    irrelevant_params = %{}
    conn =
      %Plug.Conn{}
      |> Web.SubmitRestaurantController.submit(irrelevant_params)

    assert %Plug.Conn{status: 200} = conn
  end
end
