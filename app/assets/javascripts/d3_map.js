avantGarde.controller('mainCtrl', function($scope, $resource, uiGmapGoogleMapApi) {
  uiGmapGoogleMapApi.then(function(maps) {

    var lastId = 1;
    var clusterThresh = 6;

    $scope.map = {
      actualZoom: null,
      showMarkers: true,
      doCluster: true,
      options: {
        streetViewControl: false,
        panControl: false,
        maxZoom: 18,
        minZoom: 3
      },
      events: {
        idle: function (map) {
          $scope.map.actualZoom = map.getZoom();
          if ($scope.addMarkers)
            $scope.addMarkers(1000);
        }
      },
      center: {
        latitude: 32.7150,
        longitude: -117.1625
      },
      //clusterOptions: {title: 'Hi I am a Cluster!', gridSize: 60, ignoreHidden: true, minimumClusterSize: 2,
      //  imageExtension: 'png', imagePath: 'assets/images/cluster', imageSizes: [72]
      //},
      clusterOptions: {},
      zoom: 10
    };

    $scope.searchResults = {
      results: [],
      key: "result"
    };

    AvantData = $resource('/avant_data/all_data', {format: 'json'});

    AvantData.query(function(results){
      var markers = [];

      for (var i = results.length - 1; i >= 0; i--) {
        markers.push({
          "coords" : {
            "latitude": results[i].lat,
            "longitude": results[i].long
          },
          'key': 'someKey-' + lastId
        });
        lastId++;
      };
      $scope.searchResults.results = markers;
    });

  })
});