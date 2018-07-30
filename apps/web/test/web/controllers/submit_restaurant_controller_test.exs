defmodule Web.SubmitRestaurantControllerTest do
  use Web.ConnCase, async: true

  describe "the submission of a valid not shortlisted restaurant" do
    setup %{conn: conn} do
      params = %{"name" => "The #{Faker.Color.En.fancy_name} restaurant"}
      path = submit_restaurant_path(conn, :submit)
      %{conn: post(conn, path, params), name: params["name"]}
    end

    test "displays a success feedback", %{conn: conn, name: name} do
      assert html_response(conn, 200) =~ success_feedback_for(name)
    end

    defp success_feedback_for(name) do
      "Thanks! you've successfully shortlisted #{name}."
    end
  end
end
