defmodule MbtaTrackerWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:routes", _message, socket) do
    {:ok, socket}
  end

  def handle_in("route-update", %{"line" => line, "destination" => destination, "arrive" => arrive}, socket) do
      broadcast! socket, "route-update", %{line: line, destination: destination, arrive: arrive}
      {:noreply, socket}
  end
end
