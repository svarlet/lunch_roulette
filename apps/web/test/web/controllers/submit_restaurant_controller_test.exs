defmodule Web.SubmitRestaurantControllerTest do
  use Web.ConnCase, async: true

  describe "the submission of a valid not shortlisted restaurant" do
    setup %{conn: conn} do
      params = %{"name" => "Not a shortlisted restaurant"}
      path = submit_restaurant_path(conn, :submit)
      %{conn: post(conn, path, params), params: params}
    end

    test "displays a success feedback", %{conn: conn, params: params} do
      assert html_response(conn, 200) =~
               "Thanks! you've successfully shortlisted #{params["name"]}."
    end
  end
end
