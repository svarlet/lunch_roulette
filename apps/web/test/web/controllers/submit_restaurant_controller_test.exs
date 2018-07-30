defmodule Web.SubmitRestaurantControllerTest do
  use Web.ConnCase, async: true

  alias Plug.Conn

  describe "the submission of a valid not shortlisted restaurant" do
    setup %{conn: conn} do
      params = %{"name" => "Not a shortlisted restaurant"}
      path = submit_restaurant_path(conn, :submit)
      %{conn: post(conn, path, params)}
    end

    test "responds with http status 200", %{conn: conn} do
      assert %Conn{status: 200} = conn
    end

    test "responds with content-type: text/html and utf-8 charset", %{conn: conn} do
      assert response_content_type(conn, :html) =~ "charset=utf-8"
    end
  end
end
