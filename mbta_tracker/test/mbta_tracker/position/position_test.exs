defmodule MbtaTracker.PositionTest do
  use MbtaTracker.DataCase

  alias MbtaTracker.Position

  describe "locations" do
    alias MbtaTracker.Position.Location

    @valid_attrs %{lat: 120.5, lon: 120.5}
    @update_attrs %{lat: 456.7, lon: 456.7}
    @invalid_attrs %{lat: nil, lon: nil}

    def location_fixture(attrs \\ %{}) do
      {:ok, location} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Position.create_location()

      location
    end

    test "list_locations/0 returns all locations" do
      location = location_fixture()
      assert Position.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Position.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      assert {:ok, %Location{} = location} = Position.create_location(@valid_attrs)
      assert location.lat == 120.5
      assert location.lon == 120.5
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Position.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()
      assert {:ok, location} = Position.update_location(location, @update_attrs)
      assert %Location{} = location
      assert location.lat == 456.7
      assert location.lon == 456.7
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Position.update_location(location, @invalid_attrs)
      assert location == Position.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Position.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Position.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Position.change_location(location)
    end
  end
end
