function ESRIMap (Map, MapView, Search) {

      var map = new Map({
        basemap: "topo-vector"
      });

      var view = new MapView({
        container: "viewDiv",
        map: map,
        center: [-118.80500, 34.02700],
        zoom: 13});
        
      var search = new Search({
      	view: view
      });
		view.ui.add(search, "top-right");
		
		view.on("click", function(evt){
        search.clear();
        view.popup.clear();
        if (search.activeSource) {
          var geocoder = search.activeSource.locator; // World geocode service
          var params = {
            location: evt.mapPoint
          };
          geocoder.locationToAddress(params)
            .then(function(response) { // Show the address found
              var address = response.address;
              showPopup(address, evt.mapPoint);
            }, function(err) { // Show no address found
              showPopup("No address found.", evt.mapPoint);
            });
        }
      });
};
