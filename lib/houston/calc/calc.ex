defmodule Houston.Calc do
  alias Houston.Planets.Planet
  alias Houston.Ships.Ship

  def fuel_for_launch(%Ship{mass: mass}, %Planet{gravity: gravity})
      when is_integer(mass) and is_float(gravity),
      do: calc_total_required_fuel(mass, gravity, 0.042, 33, 0)

  def fuel_for_launch(mass, planet), do: {:error, "Invalid arguements", [mass, planet]}

  def fuel_for_landing(%Ship{mass: mass}, %Planet{gravity: gravity})
      when is_integer(mass) and is_float(gravity),
      do: calc_total_required_fuel(mass, gravity, 0.033, 42, 0)

  def fuel_for_landing(mass, planet), do: {:error, "Invalid arguements", [mass, planet]}

  # additional required fuel increases the total weight of the ship,
  # hence the need for a recursive function until additional required fuel for extra mass is 0 or below
  defp calc_total_required_fuel(mass, gravity, a, b, total_fuel) do
    add_fuel = Kernel.floor(mass * gravity * a - b)

    if add_fuel > 0,
      do: calc_total_required_fuel(add_fuel, gravity, a, b, total_fuel + add_fuel),
      else: total_fuel
  end

  # since we need to carry the total fuel required for the trip from start,
  # we need to calculate the total fuel required for the trip from last to first
  def fuel_for_round_trip(mass, route) do
    route
    |> Enum.reverse()
    |> Enum.reduce(0, fn
      {:launch, gravity}, total_fuel ->
        total_fuel + fuel_for_launch(%Ship{mass: mass + total_fuel}, %Planet{gravity: gravity})

      {:land, gravity}, total_fuel ->
        total_fuel + fuel_for_landing(%Ship{mass: mass + total_fuel}, %Planet{gravity: gravity})
    end)
  end
end
