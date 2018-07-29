defmodule Web.SubmitRestaurantController do
  use Web, :controller

  require Logger
  def submit(conn, params) do
    Logger.debug inspect(params)

    conn
    |> render("index.html")
  end
end
