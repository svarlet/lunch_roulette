defmodule Web.SubmitRestaurantController do
  use Web, :controller

  def submit(conn, %{"name" => restaurant_name}) do
    conn
    |> put_flash(:success, "Thanks! you've successfully shortlisted #{restaurant_name}.")
    |> redirect(to: page_path(conn, :home))
  end
end
