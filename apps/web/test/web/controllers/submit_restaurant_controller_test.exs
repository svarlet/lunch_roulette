defmodule Web.SubmitRestaurantControllerTest do
  use Web.ConnCase, async: true

  describe "the submission of a valid not shortlisted restaurant" do
    setup %{conn: conn} do
      params = %{"name" => "The #{Faker.Color.En.fancy_name()} restaurant"}
      path = submit_restaurant_path(conn, :submit)
      %{conn: post(conn, path, params), name: params["name"]}
    end

    test "redirects to the home page", %{conn: conn} do
      assert redirected_to(conn) == page_path(conn, :home)
    end

    test "sets a flash message", %{conn: conn, name: name} do
      expected_flash_message = success_feedback_for(name)
      assert %{"success" => ^expected_flash_message} = get_flash(conn)
    end

    defp success_feedback_for(name) do
      "Thanks! you've successfully shortlisted #{name}."
    end
  end

  describe "the submission of a valid shortlisted restaurant" do
    test "redirects to the home page", %{conn: conn} do
      params = %{"name" => "The already registered restaurant"}
      path = submit_restaurant_path(conn, :submit)
      conn = post(conn, path, params)
      assert redirected_to(conn) == page_path(conn, :home)
    end
  end
end
