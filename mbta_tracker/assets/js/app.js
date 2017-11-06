// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
//

// Taken from Nat's Ajax Cart lecture notes.

let handlebars = require("handlebars");

$(function() {
    if (!$("#stops").length > 0) {
        return;
    }

    console.log("running");

    // Sample Data
    let data = {stop: "Ruggles", routes: [{line: "Orange", direction: "Forest Hill", time: "5"}, {line: "Green", direction: "Heath Street", time: "7"}]}


    let stops = $($("#stops")[0]);

    console.log(stops)

    let code = stops.html();

    console.log(code)

    let tmpl = handlebars.compile(code);

    let html = tmpl(data);

    console.log(html)
    $("#showStops").html(html);
})
