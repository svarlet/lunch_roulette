defmodule Web.SubmitRestaurantControllerTest do
  use ExUnit.Case, async: true

  alias Web.SubmitRestaurantController
  alias Plug.Conn

  describe "the submission of a valid not shortlisted restaurant" do
    test "responds with http status 200" do
      params = %{"name" => "Not a shortlisted restaurant"}

      conn =
        %Conn{}
        |> SubmitRestaurantController.submit(params)

      assert %Conn{status: 200} = conn
    end
  end
end
