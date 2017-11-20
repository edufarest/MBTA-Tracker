// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "lib/web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

socket.connect()
let handlebars = require("handlebars")

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("room:routes", {})

let position = document.querySelector("#position");



channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })


trigger.addEventListener("click", event => {
    console.log("Updating")

    let lat = position.dataset.lat;
    let lon = position.dataset.lon;

    channel.push("location", {lat: lat, lon: lon})
})



channel.on("route-update", payload => {

    // console.log(payload.body)

    var body = JSON.parse(JSON.stringify(payload.body));

    var data = [{}];

    data.mode = body.mode[0].mode_name
    data.trips = [];

    // console.log(data)

    let routes = body.mode[0].route;

    for (var i = 0; i < routes.length; i++) {
    	let route = routes[i];
    	let route_name = route.route_name;

    	console.log(route.direction[0].trip)

    	for (var j = 0; j < route.direction[0].trip.length; j++) {

    		let trip = route.direction[0].trip[j]
    		// console.log(trip)

    		let headsign = trip.trip_headsign
    		let arrival = parseInt(trip.pre_away / 60)

    		let jTrip = {"route_name" : route_name, "headsign" : headsign, "arrival" : arrival};
    		// console.log(jTrip)

    		data.trips.push(jTrip)

    	}
    }

    console.log(data)

    data.stop_name = body.stop_name

    // Update view

    let trips = $($("#trips")[0]);

    let code = trips.html();

    let tmpl = handlebars.compile(code)
    let html = tmpl(data)

    $("#showTrips").html(html);
})

export default socket
