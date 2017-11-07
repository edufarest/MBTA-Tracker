defmodule MbtaTracker do
  @moduledoc """
  MbtaTracker keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  # Requests data from API
  def getStop!(lat, lon) do

    key = "v_ULBvHWlEK0J-_BMEPb_Q"
    
    resp = HTTPoison.get!("http://realtime.mbta.com/developer/api/v2/stopsbylocation?api_key=#{key}&lat=#{lat}&lon=#{lon}&format=json")
    data = Poison.decode!(resp.body)

    # Clostest stop
    stop = Enum.at(data["stop"], 0)
    stop_id = stop["stop_id"]

    # Get predictions

    resp = HTTPoison.get!("http://realtime.mbta.com/developer/api/v2/predictionsbystop?api_key=#{key}&stop=#{stop_id}&format=json")
    data = Poison.decode!(resp.body)

    route = Enum.at(data["mode"], 0)
  end
end
