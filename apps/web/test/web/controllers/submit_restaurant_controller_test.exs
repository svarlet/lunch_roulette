defmodule Web.SubmitRestaurantControllerTest do
  use Web.ConnCase, async: true

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

    test "respondes with content-type: text/html and utf-8 charset" do
      params = %{"name" => "Not a shortlisted restaurant"}
      conn = SubmitRestaurantController.submit(%Conn{}, params)
      assert response_content_type(conn, :html) =~ "charset=utf-8"
    end
  end
end
