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
    test "redirects to the home page", %{conn: conn} do
      params = %{"name" => Faker.Company.name()}
      path = submit_restaurant_path(conn, :submit)

      di_container = %{
        save: fn _ -> {:error, {:irrelevant_category, :irrelevant_reason}} end
      }

      conn =
        conn
        |> recycle()
        |> assign(:di_container, di_container)
        |> post(path, params)

      assert redirected_to(conn) == page_path(conn, :home)
    end

    test "report error with a flash message", %{conn: conn} do
      params = %{"name" => Faker.Company.name()}
      path = submit_restaurant_path(conn, :submit)

      di_container = %{
        save: fn _ -> {:error, {:irrelevant_category, :irrelevant_reason}} end
      }

      conn =
        conn
        |> recycle()
        |> assign(:di_container, di_container)
        |> post(path, params)

      assert %{"error" => "Error: irrelevant_category of #{params["name"]} failed because of irrelevant_reason."} == get_flash(conn)
    end
  end
end
