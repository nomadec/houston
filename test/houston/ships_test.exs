defmodule Houston.ShipsTest do
  use Houston.DataCase

  alias Houston.Ships

  describe "ships" do
    alias Houston.Ships.Ship

    import Houston.ShipsFixtures

    @invalid_attrs %{mass: nil, max_load: nil, name: nil}

    test "list_ships/0 returns all ships" do
      ship = ship_fixture()
      assert Ships.list_ships() == [ship]
    end

    test "get_ship!/1 returns the ship with given id" do
      ship = ship_fixture()
      assert Ships.get_ship!(ship.id) == ship
    end

    test "create_ship/1 with valid data creates a ship" do
      valid_attrs = %{mass: 42, max_load: 42, name: "some name"}

      assert {:ok, %Ship{} = ship} = Ships.create_ship(valid_attrs)
      assert ship.mass == 42
      assert ship.max_load == 42
      assert ship.name == "some name"
    end

    test "create_ship/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ships.create_ship(@invalid_attrs)
    end

    test "update_ship/2 with valid data updates the ship" do
      ship = ship_fixture()
      update_attrs = %{mass: 43, max_load: 43, name: "some updated name"}

      assert {:ok, %Ship{} = ship} = Ships.update_ship(ship, update_attrs)
      assert ship.mass == 43
      assert ship.max_load == 43
      assert ship.name == "some updated name"
    end

    test "update_ship/2 with invalid data returns error changeset" do
      ship = ship_fixture()
      assert {:error, %Ecto.Changeset{}} = Ships.update_ship(ship, @invalid_attrs)
      assert ship == Ships.get_ship!(ship.id)
    end

    test "delete_ship/1 deletes the ship" do
      ship = ship_fixture()
      assert {:ok, %Ship{}} = Ships.delete_ship(ship)
      assert_raise Ecto.NoResultsError, fn -> Ships.get_ship!(ship.id) end
    end

    test "change_ship/1 returns a ship changeset" do
      ship = ship_fixture()
      assert %Ecto.Changeset{} = Ships.change_ship(ship)
    end
  end
end
