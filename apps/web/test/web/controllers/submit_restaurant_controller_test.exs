defmodule Web.SubmitRestaurantControllerTest do
  use Web.ConnCase, async: true

  describe "the submission of a valid not shortlisted restaurant" do
    setup %{conn: conn} do
      params = %{"name" => Faker.Company.name()}
      path = submit_restaurant_path(conn, :submit)

      conn =
        conn
        |> recycle()
        |> assign(:di_container, %{save: fn restaurant -> {:ok, restaurant} end})
        |> post(path, params)

      %{conn: conn, name: params["name"]}
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
    setup %{conn: conn} do
      params = %{"name" => Faker.Company.name()}
      path = submit_restaurant_path(conn, :submit)

      conn =
        conn
        |> recycle()
        |> assign(:di_container, %{save: fn _ -> {:error, :already_registered} end})
        |> post(path, params)

      %{conn: conn, name: params["name"]}
    end

    test "redirects to the home page", %{conn: conn} do
      assert redirected_to(conn) == page_path(conn, :home)
    end

    test "sets a flash message", %{conn: conn, name: name} do
      assert %{"error" => "#{name} is already registered."} == get_flash(conn)
    end
  end

  describe "the submission of an invalid restaurant" do
    setup %{conn: conn} do
      params = %{"name" => Faker.Company.name()}
      path = submit_restaurant_path(conn, :submit)
      category = Faker.Random.Elixir.random_bytes(3)
      reason = Faker.Random.Elixir.random_bytes(3)

      di_container = %{
        save: fn _ -> {:error, {category, reason}} end
      }

      conn =
        conn
        |> recycle()
        |> assign(:di_container, di_container)
        |> post(path, params)

      %{conn: conn, name: params["name"], category: category, reason: reason}
    end

    test "redirects to the home page", %{conn: conn} do
      assert redirected_to(conn) == page_path(conn, :home)
    end

    test "report error with a flash message", context do
      assert %{"error" => "Error: #{context.category} of #{context.name} failed because of #{context.reason}."} == get_flash(context.conn)
    end
  end
end
