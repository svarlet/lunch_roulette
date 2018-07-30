defmodule Web.SubmitRestaurantControllerTest do
  use ExUnit.Case, async: true

  describe "the submission of a valid not shortlisted restaurant" do
    test "responds with http status 200" do
      params = %{"name" => "Not a shortlisted restaurant"}

      conn =
        %Plug.Conn{}
        |> Web.SubmitRestaurantController.submit(params)

      assert %Plug.Conn{status: 200} = conn
    end
  end
end
