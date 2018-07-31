defmodule Web.SubmitRestaurantController do
  use Web, :controller

  def submit(conn, %{"name" => restaurant_name}) do
    conn
    |> redirect(to: page_path(conn, :home))
  end
end
