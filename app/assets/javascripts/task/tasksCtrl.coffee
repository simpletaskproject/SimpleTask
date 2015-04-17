angular.module('SimpleTask').controller 'TasksCtrl', ($scope, $http, List, Task, Auth, $stateParams) ->
  $scope.newTask = {}
  $scope.editedTaskID = null
  $scope.oldTitle = null

  if $stateParams.list_slug != 'all'
    List.show($stateParams.list_slug).success (task) ->
      $scope.list = task
      $scope.tasks = $scope.list.tasks
  else
    Task.index($stateParams.list_slug).success (task) ->
      $scope.tasks = task


  addHours = (date) ->
    date.setHours(date.getHours() + 12)
    date.setMinutes(date.getMinutes() - date.getTimezoneOffset())
    date.toISOString().substring(0,10)

  $scope.create = (task) ->
    Task.create($scope.newTask).success (task) ->
      $scope.tasks.push task
      $scope.newTask = {}

  $scope.edit = (task) ->
    $scope.editedTaskID = task.id
    $scope.oldTitle = task.title

  $scope.cancelEdit = (task) ->
    task.title = $scope.oldTitle
    $scope.editedTaskID = null
    $scope.oldTitle = null


  $scope.update = (task) ->
    addHours(task.date)
    Task.update(task).success (task) ->
      index = $scope.tasks.indexOf(task)
      $scope.tasks.splice(index, 1, task)
      $scope.editedTaskID = null

  $scope.destroy = (task) ->
    Task.destroy(task).success (task) ->
      index = $scope.tasks.indexOf(task)
      $scope.tasks.splice(index,1)

  $scope.complete = (task) ->
    Task.complete(task).success (task) ->
      index = $scope.tasks.indexOf(task)
      $scope.tasks.splice(index, 1)
      $scope.tasks.push task
