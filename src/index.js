import "./main.css";
import { Elm } from "./Main.elm";
import * as serviceWorker from "./serviceWorker";

// by moveable type: http://www.movable-type.co.uk/scripts/latlong.html
function calculateDistance(lat1, lon1, lat2, lon2) {
  var R = 6371; // km
  var dLat = (lat2 - lat1).toRad();
  var dLon = (lon2 - lon1).toRad();
  var a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(lat1.toRad()) *
      Math.cos(lat2.toRad()) *
      Math.sin(dLon / 2) *
      Math.sin(dLon / 2);
  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  var d = R * c;
  return d.toString();
}
Number.prototype.toRad = function () {
  return (this * Math.PI) / 180;
};

document.getElementById("start").addEventListener("click", function () {
  // hide intro screen
  var intro = document.getElementById("intro");
  intro.parentNode.removeChild(intro);

  // get starting position
  var startPos;
  navigator.geolocation.getCurrentPosition(
    function (position) {
      startPos = position;
    },
    function (error) {
      alert("Error occurred getting position. Error code: " + error.code);
    }
  );

  // start elm app
  var elmApp = Elm.Main.init({
    node: document.getElementById("elm_app"),
  });

  // subscribe to position changes
  navigator.geolocation.watchPosition(function (position) {
    elmApp.ports.incomingGeoData.send(
      calculateDistance(
        startPos.coords.latitude,
        startPos.coords.longitude,
        position.coords.latitude,
        position.coords.longitude
      )
    );
  });
});

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
