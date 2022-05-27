defmodule Houston.Planets do
  @moduledoc """
  The Planets context.
  """

  alias Houston.Planets.Planet

  @dataset %{
    "Earth" => %Planet{name: "Earth", gravity: 9.807},
    "Moon" => %Planet{name: "Moon", gravity: 1.62},
    "Mars" => %Planet{name: "Mars", gravity: 3.711}
  }

  def list_planets, do: @dataset |> Map.values()

  def get_planet(id), do: @dataset |> Map.get(id)
end
