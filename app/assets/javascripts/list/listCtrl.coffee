angular.module('SimpleTask').controller 'ListCtrl', ($scope, $http, Auth, $stateParams) ->
  $scope.newList = {}
  $scope.editedListID = null

  $http.get("/api/lists/#{ $stateParams.list_slug }.json").success (data) ->
    $scope.list = data

  $http.get("/api/lists").success (data) ->
    $scope.lists = data

  $scope.create = (list) ->
    $http.post("/api/lists", list: $scope.newList ).success (response) ->
      $scope.lists.push response
      $scope.newList = {}

  $scope.edit = (list) ->
    $scope.editedListID = list.id

  $scope.cancelEdit = ->
    $scope.editedListID = null

  $scope.update = (list) ->
    $http.put("/api/lists/#{list.slug}", list: list).success (response) ->
      index = $scope.lists.indexOf(list)
      $scope.lists.splice(index, 1, list)
      $scope.editedListID = null

  $scope.destroy = (list) ->
    $http.delete("/api/lists/#{list.slug}").success (response) ->
      index = $scope.lists.indexOf(list)
      $scope.lists.splice(index,1)
