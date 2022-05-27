defmodule Houston.Ships.Ship do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ships" do
    field :mass, :integer
    field :max_load, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(ship, attrs) do
    ship
    |> cast(attrs, [:name, :mass, :max_load])
    |> validate_required([:name, :mass, :max_load])
  end
end
