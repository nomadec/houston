defmodule HoustonWeb.ShipLive.FormComponent do
  use HoustonWeb, :live_component

  alias Houston.Ships

  @impl true
  def update(%{ship: ship} = assigns, socket) do
    changeset = Ships.change_ship(ship)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"ship" => ship_params}, socket) do
    changeset =
      socket.assigns.ship
      |> Ships.change_ship(ship_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"ship" => ship_params}, socket) do
    save_ship(socket, socket.assigns.action, ship_params)
  end

  defp save_ship(socket, :edit, ship_params) do
    case Ships.update_ship(socket.assigns.ship, ship_params) do
      {:ok, _ship} ->
        {:noreply,
         socket
         |> put_flash(:info, "Ship updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_ship(socket, :new, ship_params) do
    case Ships.create_ship(ship_params) do
      {:ok, _ship} ->
        {:noreply,
         socket
         |> put_flash(:info, "Ship created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
