defmodule MbtaTracker.Position.Location do
  use Ecto.Schema
  import Ecto.Changeset
  alias MbtaTracker.Position.Location


  schema "locations" do
    field :lat, :float
    field :lon, :float

    timestamps()
  end

  @doc false
  def changeset(%Location{} = location, attrs) do
    location
    |> cast(attrs, [:lat, :lon])
    |> validate_required([:lat, :lon])
  end
end
