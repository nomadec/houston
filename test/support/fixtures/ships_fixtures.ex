defmodule Houston.ShipsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Houston.Ships` context.
  """

  @doc """
  Generate a ship.
  """
  def ship_fixture(attrs \\ %{}) do
    {:ok, ship} =
      attrs
      |> Enum.into(%{
        mass: 42,
        max_load: 42,
        name: "some name"
      })
      |> Houston.Ships.create_ship()

    ship
  end
end
