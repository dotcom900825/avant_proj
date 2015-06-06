avantGarde.controller("PackingController", ['$scope', "$resource", "$filter", "NgTableParams", function($scope, $resource, $filter, NgTableParams){
  
  $scope.visualPath = ["circle_packing"];

  $scope.currentPath = $scope.visualPath[0];

  //rendering geojson layer
  $scope.zip_hash = {};

  $scope.pathData = {

  };

  $scope.filters = {

  };

  var environment = "production";
  $scope.avantData = [];
  $scope.fullAvantData = [];

  var prefix = "";

  if (environment == "production") {
    prefix = "/viz";
  };

  $scope.scatterPlotX = "current_hiv_load";
  $scope.scatterPlotY = "age";
  $scope.scatterPlotSize = "number_of_partners";

  $scope.motionChartTime = "date_of_enrollment";
  $scope.motionChartGroup = "sex";
  $scope.motionChartX = "current_hiv_load";
  $scope.motionChartY = "age";
  $scope.motionChartSize = "number_of_partners";


  

  $scope.saveCurrentPath = function(){
    visualPath.save({paths: $scope.visualPath, filters: $scope.filters, pathName: $scope.pathName}, function(){

    })
  }

  visualPath = $resource(prefix + '/visualization_paths', {format: 'json'});


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

    if (type == "pie") {
      $scope.pieChart();
    };

    if (type == 'scatter_plot') {
      $scope.scatterPlotChart();
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

    if (name == 'scatter_plot') {
      $scope.currentPath = "scatter_plot";
      $scope.visualPath.push("scatter_plot");
      $scope.scatterPlotChart();      
    };

    if (name == "motion_chart") {
      $scope.currentPath = "motion_chart";
      $scope.visualPath.push("motion_chart");
      $scope.motionChart();
    };
  }

  $scope.tableParams = new NgTableParams({
    page: 1,            // show first page
    count: 10           // count per page

  }, {
    total: function() { return $scope.avantData.length}, // length of data
    getData: function($defer, params) {
      var orderedData = params.sorting() ? $filter('orderBy')($scope.avantData, params.orderBy()) : $scope.avantData;
      params.total(orderedData.length);
      $defer.resolve(orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count()));
    }
  });

  $scope.filterTable = function(field){
    $scope.tableParams.sorting(field, $scope.tableParams.isSortBy(field, 'asc') ? 'desc' : 'asc');
  }
  //------------------

  AvantData = $resource(prefix + '/avant_data/all_data', {format: 'json'});

  AvantData.query(function(results){
    $scope.avantData = results;
    $scope.fullAvantData = results;
    var zip_result = _.filter(results, function(obj) {return obj.zip != null});

    render_map(zip_result);
  });

  $scope.$watch("avantData", function () {
    $scope.tableParams.reload();
  });  

  AvantData.query({type: "columns"},function(results){
    $scope.hierOne = "cluster_id";
    $scope.hierTwo = "zip";

    $scope.columns = results;
    $scope.selectedColumns = ["cluster_id", "race", "inject_drug", "birth_city", "zip"];

    $scope.selectedColumns = _.map($scope.selectedColumns, function(obj){ return { field : obj }});

    //$scope.selectedColumns = ["time", "source", "destination", "protocol", "length", "info"];
    AvantData.get({type: "circle_packing", "columns[]" : [$scope.hierOne, $scope.hierTwo]}, function(results){
      $scope.nodes = results;
      
      $scope.data = results;

      $scope.circle_packing_options = {
        chart: {
          type: 'circlePacking',
          height: 400,
          width: 500,
          margin: {
            top: 30,
            right: 40,
            bottom: 50,
            left: 10
          },
          dimensions: $scope.columns,
        }  
      };

    });

  });

  $scope.addToSelectedColumns = function(column){
    if(column !== ""){
      $scope.selectedColumns.push({field: column});      
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
    $scope.tableParams.reload();
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

  GeoBoundary = $resource(prefix + "/avant_data/geojson", {format: 'json'});

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
  }

  $scope.$watch("selectedZip", function () {
    $scope.avantData = _.filter($scope.fullAvantData, function(obj){ return obj.zip == $scope.selectedZip; });
    $scope.tableParams.reload();
  });  



  //----------------------

  $scope.addColumnsParallel = function(column){
    if(column !== ""){
      $scope.selectedColumns.push({"field" : column});      
    }

    $scope.parallelCoordinate();
  }

  $scope.removeColumn = function(index){
    $scope.selectedColumns.splice(index, 1);
    $scope.parallelCoordinate();
  }

  $scope.parallelCoordinate = function(){

    var columns = _.map($scope.selectedColumns, function(obj){ return obj['field']});

    AvantData.query({type: "parallel", "columns[]" : columns, "filters[]" : [$scope.hierOne], "filter_values[]" : [$scope.name]}, function(results){
      $scope.data = results;
      $scope.parallel_coordinate_options = {
        chart: {
          type: 'parallelCoordinates',
          height: 10000,
          width: 600,
          margin: {
            top: 30,
            right: 40,
            bottom: 50,
            left: 10
          },
          dimensions: columns,
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
      $scope.pieChartColumn = "age";
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
    AvantData.query({type: "pie_chart", column: name, "filters[]" : [$scope.hierOne], "filter_values[]" : [$scope.name]}, function(results){
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

  //-------
  $scope.scatterPlotChart = function(){

    AvantData.query({type: "scatter_chart", group_by: "sex", "filters[]" : [$scope.hierOne], "filter_values[]" : [$scope.name], x: $scope.scatterPlotX, y: $scope.scatterPlotY, size: $scope.scatterPlotSize}, function(results){
      $scope.data = results;
    });

    $scope.scatter_plot_options = {
      chart: {
          type: 'scatterChart',
          height: 800,
          width: 580,
          color: d3.scale.category10().range(),
          scatter: {
              onlyCircles: false
          },
          showDistX: true,
          showDistY: true,
          tooltipContent: function(key) {
              return '<h3>' + key + '</h3>';
          },
          transitionDuration: 350,
          xAxis: {
              axisLabel: $scope.scatterPlotX,
              tickFormat: function(d){
                  return d3.format('.02f')(d);
              }
          },
          yAxis: {
              axisLabel: $scope.scatterPlotY,
              tickFormat: function(d){
                  return d3.format('.02f')(d);
              },
              axisLabelDistance: 30
          }
      }
    };
    
  }

  //-------

  $scope.motionChart = function(){

    AvantData.get({type: "motion_chart", group_by: $scope.motionChartGroup, "filters[]" : [$scope.hierOne], "filter_values[]" : [$scope.name], x: $scope.motionChartX, y: $scope.motionChartY, size: $scope.motionChartSize, time_column : $scope.motionChartTime}, function(results){
      $scope.chartObject = {};

      $scope.chartObject.type = "MotionChart";
      var motion_chart_res = results.motion_chart;
      motion_chart_res['cols'] = [
        {id: $scope.motionChartGroup, label: $scope.motionChartGroup, type: "string"},
        {id: "date", label: "Date", type: "date"},
        {id: $scope.motionChartX, label: $scope.motionChartX, type: "number"},
        {id: $scope.motionChartY, label: $scope.motionChartY, type: "number"},
        {id: $scope.motionChartSize, label: $scope.motionChartSize, type: "number"},
      ];

      $scope.chartObject.data = motion_chart_res;


      var timeline_chart_res = results.timeline_chart;
      timeline_chart_res['cols'] = [
        { type: 'string', id: 'President' },
        { type: 'date', id: 'Start' },
        { type: 'date', id: 'End' }
      ];


      $scope.timelineChartObject = {};
      $scope.timelineChartObject.type = "Timeline";
      $scope.timelineChartObject.data = timeline_chart_res;
        
    });
  }
  // $scope.motionChart = function(){
  //   AvantData.query({type: "motion_chart", time_column: "date_of_enrollment",  group_by: "sex", "filters[]" : [$scope.hierOne], "filter_values[]" : [$scope.name], x: $scope.scatterPlotX, y: $scope.scatterPlotY, size: $scope.scatterPlotSize}, function(results){
  //     $scope.data = results;

  //     $scope.motion_chart_options = {
  //       chart: {
  //         type: "motionChart",
  //         height: 550,
  //         width: 960,
  //         margin: {
  //           top: 30,
  //           right: 10,
  //           bottom: 10,
  //           left: 25
  //         }
  //       }
  //     }
  //   });

  // }



}])