avantGarde.controller("ParallelController", ['$scope', "$resource", function($scope, $resource){
  
  $scope.selectedColumns = ["age", "heroin_usage", "alcohol_consumption"];
  $scope.brushedData = [];
  AvantData = $resource('/avant_data/all_data', {format: 'json'});

  AvantData.query(function(results){
    $scope.avantData = results;
  });

  AvantData.query({query: "columns"},function(results){
    $scope.columns = results;
    $scope.dataColumn = $scope.columns[5];
  });


  ParaData = $resource('/avant_data/parallel', {format: 'json'});
  
  ParaData.query({"columns[]" : $scope.selectedColumns}, function(results){
    $scope.data = results;
  });

  $scope.addToSelectedColumns = function(column){
    if(column !== ""){
      $scope.selectedColumns.push(column);
      redraw();    
    }
  }

  function redraw(){
    ParaData.query({"columns[]" : $scope.selectedColumns}, function(results){
      $scope.data = results;
    });
  }



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

}])