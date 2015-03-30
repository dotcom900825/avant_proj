avantGarde = angular.module('avantGarde', [
  "ngResource",
  "angular-underscore",
  "nvd3",
  "uiGmapgoogle-maps",
  "renderteam.circlePacking"
]).config(function(uiGmapGoogleMapApiProvider) {
  uiGmapGoogleMapApiProvider.configure({
      //    key: 'your api key',
      v: '3.17',
      libraries: 'weather,geometry,visualization'
  });
})


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
