defmodule Houston.CalcTest do
  use Houston.DataCase

  alias Houston.Calc
  alias Houston.Planets.Planet
  alias Houston.Ships.Ship

  describe "fuel_for_launch/2 and fuel_for_landing/2" do
    setup do
      planet = %Planet{name: "Earth", gravity: 9.807}
      ship = %Ship{name: "Apollo 11", mass: 28_801}

      %{planet: planet, ship: ship}
    end

    test "Apollo 11 launch on Earth returns 19772", %{planet: planet, ship: ship} do
      assert Calc.fuel_for_launch(ship, planet) == 19_772
    end

    test "Apollo 11 launch on Earth returns 13447", %{planet: planet, ship: ship} do
      assert Calc.fuel_for_landing(ship, planet) == 13_447
    end
  end

  describe "fuel_for_round_trip/2" do
    test "Apollo 11, path: launch Earth, land Moon, launch Moon, land Earth, returns 51898" do
      mass = 28_801
      route = [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}]
      assert Calc.fuel_for_round_trip(mass, route) == 51898
    end

    test "Mission on Mars, path: launch Earth, land Mars, launch Mars, land Earth, returns 33388" do
      mass = 14_606
      route = [{:launch, 9.807}, {:land, 3.711}, {:launch, 3.711}, {:land, 9.807}]
      assert Calc.fuel_for_round_trip(mass, route) == 33388
    end

    test "Passenger ship, path: launch Earth, land Moon, launch Moon, land Mars, launch Mars, land Earth, returns 212161" do
      mass = 75_432

      route = [
        {:launch, 9.807},
        {:land, 1.62},
        {:launch, 1.62},
        {:land, 3.711},
        {:launch, 3.711},
        {:land, 9.807}
      ]

      assert Calc.fuel_for_round_trip(mass, route) == 212_161
    end
  end
end
