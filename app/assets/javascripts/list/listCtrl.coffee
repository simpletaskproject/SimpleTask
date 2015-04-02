angular.module('SimpleTask').controller 'ListCtrl', ($scope, $http, Auth, $stateParams) ->
  $scope.newList = {}

  $http.get("/api/lists/#{ $stateParams.list_slug }.json").success (data) ->
    $scope.list = data

  $http.get("/api/lists").success (data) ->
    $scope.lists = data

