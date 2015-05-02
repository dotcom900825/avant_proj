avantGarde.controller("PackingController", ['$scope', "$resource", function($scope, $resource){
  
  $scope.visualPath = ["circle_packing"];

  $scope.currentPath = $scope.visualPath[0];

  //rendering geojson layer
  $scope.zip_hash = {};

  $scope.pathData = {

  };

  $scope.filters = {

  };

  $scope.saveCurrentPath = function(){
    visualPath.save({paths: $scope.visualPath, filters: $scope.filters, pathName: $scope.pathName}, function(){

    })
  }

  visualPath = $resource('/visualization_paths', {format: 'json'});





  function generateFilter(key){
    if (key == "circle_packing"){
      $scope.filters[$scope.pathData[key]['filter']] = $scope.pathData[key]["value"]
    }

    if (key == "parallel_coordinate") {
      for (var i = 0; i < $scope.pathData[key]['filter'].length; i++) {
        $scope.filters[$scope.pathData[key]['filter'][i]["dimension"]] = $scope.pathData[key]['filter'][i]["extent"]
      };
    };
  }


  $scope.checkCurrentPath = function(type){
    if (type == $scope.currentPath) {
      return true 
    }
  }

  $scope.showVisualizationComponent = function(type){
    $scope.currentPath = type
    if (type == "parallel_coordinate") {
      $scope.parallelCoordinate();
    };
  }

  $scope.switchVisualization = function(name){
    if(name == "parallel_coordinate"){
      $scope.currentPath = "parallel_coordinate";
      $scope.visualPath.push("parallel_coordinate");
      $scope.parallelCoordinate();
    }

    if(name == "pie"){
      $scope.currentPath = "pie";
      $scope.visualPath.push("pie");
      $scope.pieChart();
    }
  }

  //------------------

  AvantData = $resource('/avant_data/all_data', {format: 'json'});

  AvantData.query(function(results){
    $scope.avantData = results;
    var zip_result = _.filter(results, function(obj) {return obj.zip != null});

    render_map(zip_result);
  });

  AvantData.query({type: "columns"},function(results){
    $scope.hierOne = "cluster_id";
    $scope.hierTwo = "zip";

    $scope.columns = results;
    $scope.selectedColumns = ["pid", "cluster_id", "race", "inject_drug", "birth_city", "zip"];
    //$scope.selectedColumns = ["time", "source", "destination", "protocol", "length", "info"];
    AvantData.get({type: "circle_packing", "columns[]" : [$scope.hierOne, $scope.hierTwo]}, function(results){
      $scope.nodes = results;
    });

  });

  $scope.addToSelectedColumns = function(column){
    if(column !== ""){
      $scope.selectedColumns.push(column);      
    }
  }


  $scope.filterMap = function(){
    AvantData.query({"filterBy": $scope.hierOne, "value": $scope.name}, function(results){
      $scope.avantData = results;
      var zip_result = _.filter(results, function(obj) {return obj.zip != null});
      render_map(zip_result);
    });
  }

  //----------------------

  
  $scope.queryData = function(){
    AvantData.get({type: "circle_packing", "columns[]" : [$scope.hierOne, $scope.hierTwo]}, function(results){
      $scope.nodes = results;
    });
  }

  $scope.$watch("name", function(){
    $scope.filterMap();

    $scope.pathData["circle_packing"] = {
      "filter": $scope.hierOne,
      "value": $scope.name
    };
    generateFilter("circle_packing");
  })

  //----------------------
  angular.extend($scope, {
    center: {
        lat: 32.7734,
        lng: -117.017,
        zoom: 10
    },
    defaults: {
        maxZoom: 14
    },
    legend: {
      colors: [ '#800026', '#BD0026', '#E31A1C', '#FC4E2A', '#FD8D3C', '#FEB24C', '#FED976' ],
      labels: [ "> 35", "> 30", "> 25", "> 20", "> 15", "> 10", "> 5" ]
    }
  });

  GeoBoundary = $resource("/avant_data/geojson", {format: 'json'});

  function render_map(zip_result){
    $scope.zip_hash = {};
    _.map(zip_result, function(obj){
      if ($scope.zip_hash[obj.zip] == null){
        $scope.zip_hash[obj.zip] = 1;        
      }
      else{
        $scope.zip_hash[obj.zip] += 1;        
      }
    })
    GeoBoundary.get(render_geojson);

  }

  function render_geojson(results){
    angular.extend($scope, {
      geojson: {
        data: results,
        style: style,
        resetStyleOnMouseout: true
      }
    });
  }


  function getColor(d){
    if (d != null){
      return d > 35 ? '#800026' :
       d > 30  ? '#BD0026' :
       d > 25  ? '#E31A1C' :
       d > 20  ? '#FC4E2A' :
       d > 15   ? '#FD8D3C' :
       d > 10   ? '#FEB24C' :
       d > 5   ? '#FED976' :
                  '#FFEDA0';
    }else{
      return "grey";
    }
  }

  function style(feature) {
      return {
          fillColor: getColor($scope.zip_hash[parseInt(feature.properties.ZCTA5CE10)]),
          weight: 2,
          opacity: 1,
          color: 'white',
          dashArray: '3',
          fillOpacity: 0.7
      };
  }

  $scope.$on("leafletDirectiveMap.geojsonMouseover", function(ev, feature, leafletEvent) {
      countryMouseover(feature, leafletEvent);
  });

  $scope.$on("leafletDirectiveMap.geojsonClick", function(ev, featureSelected, leafletEvent) {
      zipClick(featureSelected, leafletEvent);
  });

  function zipClick(feature, leafletEvent) {
    var layer = leafletEvent.target;
    layer.setStyle({
        weight: 2,
        color: '#666',
        fillColor: 'red'
    });
    layer.bringToFront();
    $scope.selectedZip = feature.properties.ZCTA5CE10;
  }

  function countryMouseover(feature, leafletEvent) {
    var layer = leafletEvent.target;
    layer.setStyle({
        weight: 2,
        color: '#666',
        fillColor: 'white'
    });
    layer.bringToFront();
    $scope.selectedZip = feature.properties.ZCTA5CE10;
  }


  //----------------------

  $scope.parallelCoordinate = function(){

    AvantData.query({type: "parallel", "columns[]" : $scope.selectedColumns, "filters[]" : [$scope.hierOne], "filter_values[]" : [$scope.name]}, function(results){
      $scope.data = results;
      $scope.parallel_coordinate_options = {
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
                console.log(e);
                var zip_result = _.filter(e.active, function(obj) {return obj.zip != null});
                render_map(zip_result);

                $scope.brushedData = e.active; 
                $scope.pathData["parallel_coordinate"] = {"filter": e.filters};
                generateFilter("parallel_coordinate");          
              })
            }
          }
        }  
      };
    });
  }


  //----------------------

  $scope.pieChart = function(){

    AvantData.query({type: "pie_chart", column: "age", "filters[]" : [$scope.hierOne], "filter_values[]" : [$scope.name]}, function(results){
      $scope.data = results;
    });

    $scope.pie_options = {
      chart: {
        type: 'pieChart',
        height: 500,
        width: 580,
        x: function(d){return d.key;},
        y: function(d){return d.y;},
        showLabels: true,
        transitionDuration: 500,
        labelThreshold: 0.01,
        legend: {
          margin: {
            top: 5,
            right: 35,
            bottom: 5,
            left: 0
          }
        }
      }
    }; 
  }

  $scope.redrawPieChart = function(name){
    AvantData.query({type: "pie_chart", column: name}, function(results){
      $scope.data = results;
    });
  }
  // PieData = $resource('/avant_data/pie_chart', {format: 'json'});

  // PieData.query({column: "age"}, function(results){
  //   $scope.data = results;
  // });

  //-------------------
  $scope.stackedAreaChart = function(){
    $scope.stacked_area_options = {
      chart: {
          type: 'stackedAreaChart',
          height: 450,
          margin : {
              top: 20,
              right: 20,
              bottom: 60,
              left: 40
          },
          x: function(d){return d[0];},
          y: function(d){return d[1];},
          useVoronoi: false,
          clipEdge: true,
          transitionDuration: 500,
          useInteractiveGuideline: true,
          xAxis: {
              showMaxMin: false,
              tickFormat: function(d) {
                  return d3.time.format('%x')(new Date(d))
              }
          },
          yAxis: {
              tickFormat: function(d){
                  return d3.format(',.2f')(d);
              }
          }
      }
    };
    
  }



}])