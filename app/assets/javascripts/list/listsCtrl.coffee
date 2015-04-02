angular.module('SimpleTask').controller 'ListsCtrl', ($scope, $http, List, Auth, $stateParams) ->
  $scope.newList = {}
  $scope.editedListID = null

  List.index().success (response) ->
    $scope.lists = response

  $scope.create = (list) ->
    List.create($scope.newList).success (response) ->
      $scope.lists.push response
      $scope.newList = {}

  $scope.edit = (list) ->
    $scope.editedListID = list.id

  $scope.cancelEdit = ->
    $scope.editedListID = null

  $scope.update = (list) ->
    List.update(list).success (response) ->
      index = $scope.lists.indexOf(list)
      $scope.lists.splice(index, 1, list)
      $scope.editedListID = null

  $scope.destroy = (list) ->
    List.destroy(list).success (response) ->
      index = $scope.lists.indexOf(list)
      $scope.lists.splice(index,1)
