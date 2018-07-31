defmodule Web.SubmitRestaurantController do
  use Web, :controller

  alias Domain.Restaurant

  def submit(conn, %{"name" => restaurant_name} = params) do
    result = Domain.SubmitRestaurant.Policy.submit(params, conn.assigns.di_container.save)
    case result do
      {:error, :already_registered} ->
        conn
        |> put_flash(:error,  "#{restaurant_name} is already registered.")
        |> redirect(to: page_path(conn, :home))
      {:ok, %Restaurant{name: name}} ->
        conn
        |> put_flash(:success, "Thanks! you've successfully shortlisted #{name}.")
        |> redirect(to: page_path(conn, :home))
      {:error, {category, reason}} ->
        conn
        |> put_flash(:error, "Error: #{category} of #{restaurant_name} failed because of #{reason}.")
        |> redirect(to: page_path(conn, :home))
    end
  end
end
