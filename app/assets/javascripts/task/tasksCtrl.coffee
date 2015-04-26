angular.module('SimpleTask').controller 'TasksCtrl', ($scope, $http, List, Task, Auth, $stateParams) ->
  $scope.newTask = {}
  $scope.editedTaskID = null
  oldTask = {}
  specialSlugs = ['all','today']
  $scope.mydp = {}

  if specialSlugs.indexOf($stateParams.list_slug) == -1
    List.show($stateParams.list_slug).success (list) ->
      $scope.list = list
      $scope.tasks = $scope.list.tasks
  else
    Task.index($stateParams.list_slug).success (tasks) ->
      $scope.tasks = tasks

  $scope.open = ($event) ->
    $event.preventDefault()
    $event.stopPropagation()
    $scope.mydp.opened = true

  $scope.dateOptions =
    formatYear: 'yy',
    startingDay: 1

  $scope.create = (task) ->
    Task.create($scope.newTask).success (newTask) ->
      $scope.tasks.push newTask
      $scope.newTask = {}

  $scope.edit = (task) ->
    $scope.editedTaskID = task.id
    oldTask = angular.copy(task)

  $scope.cancelEdit = (task) ->
    index = $scope.tasks.indexOf(task)
    $scope.tasks.splice(index, 1, oldTask)
    $scope.editedTaskID = null
    oldTask = {}


  $scope.update = (task) ->
    Task.update(task).success (updatedTask) ->
      index = $scope.tasks.indexOf(task)
      $scope.tasks.splice(index, 1, updatedTask)
      $scope.editedTaskID = null

  $scope.destroy = (task) ->
    Task.destroy(task).success ->
      index = $scope.tasks.indexOf(task)
      $scope.tasks.splice(index,1)

  $scope.complete = (task) ->
    Task.complete(task).success (completedTask) ->
      index = $scope.tasks.indexOf(task)
      $scope.tasks.splice(index, 1)
      $scope.tasks.push completedTask
