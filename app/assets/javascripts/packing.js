avantGarde.controller("PackingController", ['$scope', "$resource", "uiGmapGoogleMapApi", function($scope, $resource, uiGmapGoogleMapApi){
    
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

    AvantData.query(function(results){
      var markers = [];

      $scope.avantData = results;

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

    AvantData.query({query: "columns"},function(results){
      $scope.columns = results;
      $scope.selectedColumns = ["pid", "cluster_id", "race", "inject_drug", "birth_city"];
    });

  }) 

  AvantData = $resource('/avant_data/all_data', {format: 'json'});


  $scope.addToSelectedColumns = function(column){
    if(column !== ""){
      $scope.selectedColumns.push(column);      
    }
  }

  $scope.queryData = function(){
    PackData.get({"columns[]" : [$scope.hierOne, $scope.hierTwo, $scope.hierThree]}, function(results){
      $scope.nodes = results;
    });
  }

  $scope.filterMap = function(){
    AvantData.query({"filterBy": $scope.hierOne, "value": $scope.name}, function(results){
      var markers = [];

      $scope.avantData = results;
      var lastId = 1;
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
  }

  PackData = $resource('/avant_data/circle_packing', {format: 'json'});

  $scope.hierOne = "cluster_id";
  $scope.hierTwo = "zip";

  $scope.visualPath = ["circle_packing"];
  
  PackData.get({"columns[]" : [$scope.hierOne, $scope.hierTwo]}, function(results){
    $scope.nodes = results;
  });

  //----------------------

  ParaData = $resource('/avant_data/parallel', {format: 'json'});

  $scope.parallelCoordinate = function(){
    ParaData.query({"columns[]" : $scope.selectedColumns, "hierOne" : $scope.hierOne, "value" : $scope.name}, function(results){
      $scope.data = results;
      $scope.options = {
        chart: {
          type: 'parallelCoordinates',
          height: 450,
          width: 600,
          margin: {
            top: 30,
            right: 40,
            bottom: 50,
            left: 10
          },
          dimensions: $scope.selectedColumns,
          dispatch: {
            brush : function(e){
              $scope.$apply(function(){
                $scope.brushedData = e.active;            
              })
            }
          }
        }  
      };
    });
  }

  $scope.$watch("name", function(){
    $scope.filterMap();
  })

  //----------------------
  // PieData = $resource('/avant_data/pie_chart', {format: 'json'});

  // PieData.query({column: "age"}, function(results){
  //   $scope.data = results;
  // });



}])