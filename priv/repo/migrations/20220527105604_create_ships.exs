defmodule Houston.Repo.Migrations.CreateShips do
  use Ecto.Migration

  def change do
    create table(:ships) do
      add :name, :string
      add :mass, :integer
      add :max_load, :integer

      timestamps()
    end
  end
end
