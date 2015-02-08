avantGarde.controller('PieChartController', ['$scope', "$resource", function($scope, $resource){
  $scope.filterBy = "age";
  AvantData = $resource('/avant_data/all_data', {format: 'json'});

  AvantData.query(function(results){
    $scope.avantData = results;
  });

  Columns = $resource('/avant_data/all_data?query=columns', {format: 'json'});

  Columns.query(function(results){
    $scope.columns = results;
    $scope.dataColumn = $scope.columns[5];

    $scope.selectedColumns = results.slice(0,5);
    $scope.selectedColumns.unshift($scope.dataColumn);
  });

  $scope.addToSelectedColumns = function(column){
    if(column !== ""){
      $scope.selectedColumns.push(column);      
    }
  }

  $scope.redraw = function(name){
    PieData.query({column: name}, function(results){
      $scope.data = results;
      $scope.selectedColumns.push(name);      
    });
  }

  PieData = $resource('/avant_data/pie_chart', {format: 'json'});

  PieData.query({column: "age"}, function(results){
    $scope.data = results;
  });

  $scope.options = {
    chart: {
      type: 'pieChart',
      height: 600,
      width: 600,
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
      },
      pie: {
        dispatch : {
          elementClick : function(e){
            $scope.$apply(function(){
              $scope.filterBy = e.label;
            })
          }          
        }
      }
    }
  };



}]);