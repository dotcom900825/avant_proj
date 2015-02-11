avantGarde = angular.module('avantGarde', [
  "ngResource",
  "angular-underscore",
  "nvd3",
  "uiGmapgoogle-maps",
  "renderteam.circlePacking"
]);


avantGarde.filter('columnFilter', function(){
  return function(items, filterValue, dataColumn){
    var results = [];
    for(var i = 0; i < items.length; i++){
      if(items[i][dataColumn] == filterValue){
        results.push(items[i]);
      }
    };

    return results;
  }
});