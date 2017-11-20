defmodule MbtaTrackerWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:routes", _message, socket) do
    {:ok, socket}
  end

  def handle_in("route-update", %{"line" => line, "destination" => destination, "arrive" => arrive}, socket) do
  	  

      broadcast! socket, "route-update", %{line: line, destination: destination, arrive: arrive}
      {:noreply, socket}
  end

  def handle_in("location", %{"lat" => lat, "lon" => lon}, socket) do
  	IO.puts("Getting location")
  	IO.puts(lat)

  	stop = MbtaTracker.getStop!(lat, lon)

  	predictions = MbtaTracker.getPredictions!(stop["stop_id"])

  	broadcast! socket, "route-update", %{body: predictions}

  	{:noreply, socket}
  end
end
