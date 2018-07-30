defmodule Web.SubmitRestaurantController do
  use Web, :controller

  def submit(conn, %{"name" => restaurant_name}) do
    conn
    |> put_resp_content_type("text/html")
    |> put_status(200)
    |> render("index.html", restaurant_name: restaurant_name)
  end
end
