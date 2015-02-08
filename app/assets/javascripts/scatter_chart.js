avantGarde.controller("ScatterChart", ['$scope', "$resource", function($scope, $resource){
  
  $scope.selectedColumns = ["methamphetamine_usage", "alcohol_consumption"];
  AvantData = $resource('/avant_data/all_data', {format: 'json'});

  AvantData.query(function(results){
    $scope.avantData = results;
  });

  AvantData.query({query: "columns"},function(results){
    $scope.columns = results;
    $scope.dataColumn = $scope.columns[5];
  });


  ScatterData = $resource('/avant_data/scatter_chart', {format: 'json'});
  
  // ParaData.query({"columns[]" : $scope.selectedColumns}, function(results){
  //   $scope.data = results;
  // });

  // $scope.addToSelectedColumns = function(column){
  //   if(column !== ""){
  //     $scope.selectedColumns.push(column);
  //     redraw();    
  //   }
  // }
  ScatterData.query({"group" : $scope.dataColumn}, function(results){
    $scope.data = results;
  });

  $scope.redraw = function(){
  };



  $scope.options = {
    chart: {
      type: 'scatterChart',
      height: 450,
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
        axisLabel: 'Number of sexual partners',
        tickFormat: function(d){
          return d3.format('.02f')(d);
        }
      },
      yAxis: {
        axisLabel: 'Education in years',
        tickFormat: function(d){
          return d3.format('.02f')(d);
        },
        axisLabelDistance: 30
      }
    }
  };

//  $scope.data = generateData(1,40);

  /* Random Data Generator (took from nvd3.org) */
  function generateData(groups, points) {
      var data = [],
          shapes = ['circle', 'cross', 'triangle-up', 'triangle-down', 'diamond', 'square'],
          random = d3.random.normal();

      for (var i = 0; i < groups; i++) {
          data.push({
              key: 'Group ' + i,
              values: []
          });

          for (var j = 0; j < points; j++) {
              data[i].values.push({
                  x: random()
                  , y: random()
                  , size: Math.random()
                  , shape: shapes[j % 6]
              });
          }
      }
      console.log(data);
      return data;
  }

}])