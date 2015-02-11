avantGarde.controller("PackingController", ['$scope', "$resource", function($scope, $resource){
  
  AvantData = $resource('/avant_data/all_data', {format: 'json'});

  AvantData.query(function(results){
    $scope.avantData = results;
  });

  AvantData.query({query: "columns"},function(results){
    $scope.columns = results;
    $scope.selectedColumns = ["pid", "cluster_id", "race", "inject_drug", "birth_city"];
  });

  $scope.addToSelectedColumns = function(column){
    if(column !== ""){
      $scope.selectedColumns.push(column);      
    }
  }

  $scope.queryData = function(){
    PackData.get({"columns[]" : [$scope.hierOne, $scope.hierTwo]}, function(results){
      $scope.nodes = results;
    });
  }

  PackData = $resource('/avant_data/circle_packing', {format: 'json'});

  $scope.hierOne = "cluster_id";
  $scope.hierTwo = "race";
  
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

  //----------------------
  // PieData = $resource('/avant_data/pie_chart', {format: 'json'});

  // PieData.query({column: "age"}, function(results){
  //   $scope.data = results;
  // });



}])