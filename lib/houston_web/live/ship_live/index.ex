defmodule HoustonWeb.ShipLive.Index do
  use HoustonWeb, :live_view

  alias Houston.Ships
  alias Houston.Ships.Ship

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :ships, list_ships())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Ship")
    |> assign(:ship, Ships.get_ship!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Ship")
    |> assign(:ship, %Ship{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Ships")
    |> assign(:ship, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    ship = Ships.get_ship!(id)
    {:ok, _} = Ships.delete_ship(ship)

    {:noreply, assign(socket, :ships, list_ships())}
  end

  defp list_ships do
    Ships.list_ships()
  end
end
