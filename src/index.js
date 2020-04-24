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
  var yards = d * 1093.61;
  return Math.round(yards); // return rounded yards
}
Number.prototype.toRad = function () {
  return (this * Math.PI) / 180;
};

function getAccuratePositionAndStart(startPos, startEffortTime) {
  navigator.geolocation.getCurrentPosition(
    function (position) {
      document.getElementById("currentAccuracy").innerHTML =
        position.coords.accuracy;
      startPos = position;

      if (startPos.coords.accuracy <= 10) {
        startElmApp(startPos);
      } else if (Date.now() - startEffortTime > 30000) {
        // 30s effort is up, show error and break
        alert("couldn't get a good enough lock within 30s");
        document.getElementById("loading").style.display = "none";
        document.getElementById("intro").style.display = "block";
      } else {
        // we still have more time to try again
        getAccuratePositionAndStart(startPos, startEffortTime);
      }
    },
    function (err) {
      alert("getCurrentPosition ERROR(" + err.code + "): " + err.message);
      getAccuratePositionAndStart(startPos, startEffortTime);
    },
    {
      enableHighAccuracy: true,
      timeout: 5000,
      maximumAge: 0,
    }
  );
}

function attemptStart() {
  // get starting position ensuring we have required accuracy
  var startPos = { coords: { accuracy: 999 } };
  var startEffortTime = Date.now();
  getAccuratePositionAndStart(startPos, startEffortTime);
}

function startElmApp(startPos) {
  var elmApp = Elm.Main.init({
    node: document.getElementById("elm_app"),
  });

  // subscribe to position changes
  navigator.geolocation.watchPosition(
    function (position) {
      elmApp.ports.incomingGeoData.send(
        calculateDistance(
          startPos.coords.latitude,
          startPos.coords.longitude,
          position.coords.latitude,
          position.coords.longitude
        )
      );
    },
    function error(err) {
      alert("watchPosition ERROR(" + err.code + "): " + err.message);
    },
    {
      enableHighAccuracy: true,
      timeout: 5000,
      maximumAge: 0,
    }
  );
}

window.onload = () => {
  document.getElementById("start").addEventListener("click", function () {
    // show loading screen
    document.getElementById("loading").style.display = "block";
    // hide intro screen
    document.getElementById("intro").style.display = "none";
    // attempt start
    attemptStart();
  });
};

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
