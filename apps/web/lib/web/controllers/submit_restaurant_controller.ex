defmodule Web.SubmitRestaurantController do
  use Web, :controller

  def submit(conn, _params) do
    conn
    |> Plug.Conn.put_resp_content_type("text/html")
    |> Plug.Conn.put_status(200)
  end
end
