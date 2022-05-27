defmodule HoustonWeb.ShipLiveTest do
  use HoustonWeb.ConnCase

  import Phoenix.LiveViewTest
  import Houston.ShipsFixtures

  @create_attrs %{mass: 42, max_load: 42, name: "some name"}
  @update_attrs %{mass: 43, max_load: 43, name: "some updated name"}
  @invalid_attrs %{mass: nil, max_load: nil, name: nil}

  defp create_ship(_) do
    ship = ship_fixture()
    %{ship: ship}
  end

  describe "Index" do
    setup [:create_ship]

    test "lists all ships", %{conn: conn, ship: ship} do
      {:ok, _index_live, html} = live(conn, Routes.ship_index_path(conn, :index))

      assert html =~ "Listing Ships"
      assert html =~ ship.name
    end

    test "saves new ship", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.ship_index_path(conn, :index))

      assert index_live |> element("a", "New Ship") |> render_click() =~
               "New Ship"

      assert_patch(index_live, Routes.ship_index_path(conn, :new))

      assert index_live
             |> form("#ship-form", ship: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#ship-form", ship: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.ship_index_path(conn, :index))

      assert html =~ "Ship created successfully"
      assert html =~ "some name"
    end

    test "updates ship in listing", %{conn: conn, ship: ship} do
      {:ok, index_live, _html} = live(conn, Routes.ship_index_path(conn, :index))

      assert index_live |> element("#ship-#{ship.id} a", "Edit") |> render_click() =~
               "Edit Ship"

      assert_patch(index_live, Routes.ship_index_path(conn, :edit, ship))

      assert index_live
             |> form("#ship-form", ship: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#ship-form", ship: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.ship_index_path(conn, :index))

      assert html =~ "Ship updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes ship in listing", %{conn: conn, ship: ship} do
      {:ok, index_live, _html} = live(conn, Routes.ship_index_path(conn, :index))

      assert index_live |> element("#ship-#{ship.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#ship-#{ship.id}")
    end
  end

  describe "Show" do
    setup [:create_ship]

    test "displays ship", %{conn: conn, ship: ship} do
      {:ok, _show_live, html} = live(conn, Routes.ship_show_path(conn, :show, ship))

      assert html =~ "Show Ship"
      assert html =~ ship.name
    end

    test "updates ship within modal", %{conn: conn, ship: ship} do
      {:ok, show_live, _html} = live(conn, Routes.ship_show_path(conn, :show, ship))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Ship"

      assert_patch(show_live, Routes.ship_show_path(conn, :edit, ship))

      assert show_live
             |> form("#ship-form", ship: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#ship-form", ship: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.ship_show_path(conn, :show, ship))

      assert html =~ "Ship updated successfully"
      assert html =~ "some updated name"
    end
  end
end
