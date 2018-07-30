defmodule Web.SubmitRestaurantController do
  use Web, :controller

  def submit(conn, _params) do
    conn
    |> put_resp_content_type("text/html")
    |> put_status(200)
    |> render("index.html")
  end
end