defmodule Web.SubmitRestaurantControllerTest do
  use Web.ConnCase, async: true

  alias Web.SubmitRestaurantController
  alias Plug.Conn

  describe "the submission of a valid not shortlisted restaurant" do
    setup do
      %{params: %{"name" => "Not a shortlisted restaurant"}}
    end

    test "responds with http status 200", %{conn: conn, params: params} do
      assert %Conn{status: 200} = SubmitRestaurantController.submit(conn, params)
    end

    test "respondes with content-type: text/html and utf-8 charset", %{conn: conn, params: params} do
      conn = SubmitRestaurantController.submit(conn, params)
      assert response_content_type(conn, :html) =~ "charset=utf-8"
    end
  end
end
