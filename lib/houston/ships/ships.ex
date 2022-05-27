defmodule Houston.Ships do
  @moduledoc """
  The Ships context.
  """

  import Ecto.Query, warn: false
  alias Houston.Repo

  alias Houston.Ships.Ship

  @doc """
  Returns the list of ships.

  ## Examples

      iex> list_ships()
      [%Ship{}, ...]

  """
  def list_ships do
    Repo.all(Ship)
  end

  @doc """
  Gets a single ship.

  Raises `Ecto.NoResultsError` if the Ship does not exist.

  ## Examples

      iex> get_ship!(123)
      %Ship{}

      iex> get_ship!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ship!(id), do: Repo.get!(Ship, id)

  @doc """
  Creates a ship.

  ## Examples

      iex> create_ship(%{field: value})
      {:ok, %Ship{}}

      iex> create_ship(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ship(attrs \\ %{}) do
    %Ship{}
    |> Ship.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ship.

  ## Examples

      iex> update_ship(ship, %{field: new_value})
      {:ok, %Ship{}}

      iex> update_ship(ship, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ship(%Ship{} = ship, attrs) do
    ship
    |> Ship.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ship.

  ## Examples

      iex> delete_ship(ship)
      {:ok, %Ship{}}

      iex> delete_ship(ship)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ship(%Ship{} = ship) do
    Repo.delete(ship)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ship changes.

  ## Examples

      iex> change_ship(ship)
      %Ecto.Changeset{data: %Ship{}}

  """
  def change_ship(%Ship{} = ship, attrs \\ %{}) do
    Ship.changeset(ship, attrs)
  end
end
