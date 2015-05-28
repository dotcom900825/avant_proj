avantGarde.controller("PircController", ['$scope', "$resource", '$filter', "NgTableParams", function($scope, $resource, $filter, NgTableParams){
  var environment = "development";
  var prefix = "";

  if (environment == "production") {
    prefix = "/viz";
  };

  PircData = $resource(prefix + '/pirc_data/all_data', {format: 'json'});
  $scope.phi_columns = ["aliases", "birth_date", "first_name", "last_name", "middle_initial", "suffix", "city", "email1", "email2", "phone1", "phone1_secure", "phone2", "phone2_secure", "phonetype1", "phonetype2", "state_province", "street_address_1", "street_address_2", "study_oppotunities", "testing_reminder", "zip_code"];
  // original_columns = ["RedCrossID", "collect_date", "aliases", "birth_date", "first_name", "last_name", "middle_initial", "suffix", "comments", "rapid2", "rapid2_test_kit", "result", "test_kit", "test_source", "not_done", "hbv_result", "hcv_result", "hiv_result", "nat_result", ];
  original_columns = ["RedCrossID", "collect_date", "city", "zip_code", "rapid2", "rapid2_test_kit", "result", "test_kit", "test_source", "not_done", "hbv_result", "hcv_result", "hiv_result", "nat_result", ];
  
  code_book = {"rapid2" : "Verification rapid test results", "rapid2_test_kit" : "Verification Test Kit Type", "result" : "Rapid test result", "test_kit" : "Test Kit Type", "test_source" : "Primary source of this info"};

  $scope.phi_toggle = false;
  $scope.pircData = [];

  //---------------------
  $scope.tableParams = new NgTableParams({
    page: 1,            // show first page
    count: 10           // count per page

  }, {
    total: function() { return $scope.pircData.length}, // length of data
    getData: function($defer, params) {
      var orderedData = params.sorting() ? $filter('orderBy')($scope.pircData, params.orderBy()) : $scope.pircData;
      params.total(orderedData.length);
      $defer.resolve(orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count()));
    }
  });

  //-------------------
  
  PircData.query({type : "columns"}, function(results){
    $scope.hierOne = "hcv_result";
    $scope.hierTwo = "hiv_result";

    role = results.pop();
    if (role == 0) {
      $scope.phi_toggle = false;
    }else{
      $scope.phi_toggle = true;
    };

    if ($scope.phi_toggle) {
      $scope.selectedColumns = original_columns;      
    }else{
      $scope.selectedColumns = original_columns;      
      $scope.selectedColumns = _.reject($scope.selectedColumns, function(ele) {return $scope.phi_columns.indexOf(ele) >= 0});
    };

    $scope.selectedColumns = _.map($scope.selectedColumns, function(obj){ code = code_book[obj] || obj; return { field : obj, name : code }});            
  })

  PircData.query(function(results){
    $scope.pircData = results;
    var zip_result = _.filter(results, function(obj) {return obj.zip_code != null});

    render_map(zip_result);

  });

  PircData.get({type: "circle_packing", "columns[]" : [$scope.hierOne, $scope.hierTwo], function(results){
    $scope.nodes = results;
  }})

  $scope.$watch("pircData", function () {
    $scope.tableParams.reload();
  });  


  $scope.togglePHI = function(){
    $scope.phi_toggle = !$scope.phi_toggle;

    if ($scope.phi_toggle) {
      $scope.selectedColumns = _.reject($scope.selectedColumns, function(ele) {return $scope.phi_columns.indexOf(ele) >= 0});      
    }else{
      $scope.selectedColumns = original_columns;
    }
  }

  //---------------------
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
      if ($scope.zip_hash[obj.zip_code] == null){
        $scope.zip_hash[obj.zip_code] = 1;        
      }
      else{
        $scope.zip_hash[obj.zip_code] += 1;        
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

}])