defmodule Web.SubmitRestaurantControllerTest do
  use Web.ConnCase, async: true

  describe "the submission of a valid not shortlisted restaurant" do
    setup %{conn: conn, restaurant_name: name} do
      params = %{"name" => name}
      path = submit_restaurant_path(conn, :submit)
      %{conn: post(conn, path, params), name: name}
    end

    @tag restaurant_name: "Not a shortlisted restaurant"
    test "displays a success feedback", %{conn: conn, name: name} do
      assert html_response(conn, 200) =~ "Thanks! you've successfully shortlisted #{name}."
    end

    @tag restaurant_name: "Yet another not shortlisted restaurant"
    test "display a success feedback for yet another not shortlisted restaurant", %{conn: conn, name: name} do
      assert html_response(conn, 200) =~ "Thanks! you've successfully shortlisted #{name}."
    end
  end
end
