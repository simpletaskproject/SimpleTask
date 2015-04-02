angular.module('SimpleTask').controller 'TasksCtrl', ($scope, $http, List, Task, Auth, $stateParams) ->
  $scope.newTask = {}
  $scope.editedTaskID = null

  List.show($stateParams.list_slug).success (response) ->
    $scope.list = response

  $scope.create = (task) ->
    Task.create($scope.newTask).success (response) ->
      $scope.list.tasks.push response
      $scope.newTask = {}

  $scope.edit = (task) ->
    $scope.editedTaskID = task.id

  $scope.cancelEdit = ->
    $scope.editedTaskID = null

  $scope.update = (task) ->
    Task.update(task).success (response) ->
      index = $scope.list.tasks.indexOf(task)
      $scope.list.tasks.splice(index, 1, task)
      $scope.editedTaskID = null

  $scope.destroy = (task) ->
    Task.destroy(task).success (response) ->
      index = $scope.list.tasks.indexOf(task)
      $scope.list.tasks.splice(index,1)


