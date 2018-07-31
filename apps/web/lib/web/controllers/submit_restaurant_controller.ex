defmodule Web.SubmitRestaurantController do
  use Web, :controller

  alias Domain.Restaurant

  def submit(conn, %{"name" => restaurant_name} = params) do
    result = Domain.SubmitRestaurant.Policy.submit(params, conn.assigns.di_container.save)
    case result do
      {:error, :already_registered} ->
        conn
        |> put_flash(:error,  "The already registered restaurant is already registered.")
        |> redirect(to: page_path(conn, :home))
      {:ok, %Restaurant{name: name}} ->
        conn
        |> put_flash(:success, "Thanks! you've successfully shortlisted #{name}.")
        |> redirect(to: page_path(conn, :home))
    end
  end
end
