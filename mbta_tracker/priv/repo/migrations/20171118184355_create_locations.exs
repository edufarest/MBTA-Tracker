defmodule MbtaTracker.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :lat, :float
      add :lon, :float

      timestamps()
    end

  end
end
