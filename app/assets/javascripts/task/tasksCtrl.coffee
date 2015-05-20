angular.module('SimpleTask').controller 'TasksCtrl', ($scope, $http, List, Task, Auth, $stateParams) ->
  $scope.newTask = {}
  $scope.editedTaskID = null
  oldTask = {}
  specialSlugs = ['all','today']
  $scope.openedTaskID = null
  datepickerWatcher = null

  if specialSlugs.indexOf($stateParams.list_slug) == -1
    List.show($stateParams.list_slug).success (list) ->
      $scope.list = list
      $scope.tasks = $scope.list.tasks
  else
    Task.index($stateParams.list_slug).success (tasks) ->
      $scope.tasks = tasks

  $scope.openTask = (task) ->
    $scope.openedTaskID = if $scope.openedTaskID == task.id then null else task.id
    $scope.editedTaskID = null

  $scope.create = (task) ->
    Task.create($scope.newTask).success (newTask) ->
      $scope.tasks.push newTask
      $scope.newTask = {}

  $scope.edit = (task, $event) ->
    if datepickerWatcher
      datepickerWatcher()
    datepickerWatcher = $scope.$watch ( (scope) ->
      task.date
    ), (newValue, oldValue) ->
      if !oldValue and newValue
        task.date = new Date(task.date.getTime() - task.date.getTimezoneOffset() * 60000)

    $event.stopPropagation()
    if $scope.editedTaskID == task.id
      index = $scope.tasks.indexOf(task)
      $scope.tasks.splice(index, 1, oldTask)
      $scope.editedTaskID = null
      oldTask = {}
    else
      $scope.editedTaskID = task.id
      oldTask = angular.copy(task)

  $scope.update = (task) ->
    Task.update(task).success (updatedTask) ->
      index = $scope.tasks.indexOf(task)
      $scope.tasks.splice(index, 1, updatedTask)
      $scope.editedTaskID = null

  $scope.destroy = (task) ->
    Task.destroy(task).success ->
      index = $scope.tasks.indexOf(task)
      $scope.tasks.splice(index,1)

  $scope.complete = (task, $event) ->
    $event.stopPropagation();
    Task.complete(task).success (completedTask) ->
      index = $scope.tasks.indexOf(task)
      $scope.tasks.splice(index, 1, completedTask)

  $scope.uncomplete = (task) ->
    Task.uncomplete(task).success (uncompletedTask) ->
      index = $scope.tasks.indexOf(task)
      $scope.tasks.splice(index, 1, uncompletedTask)

  $scope.late = (task) ->
    if task.date
      taskDate = new Date(task.date)
      yesterdaysDate = new Date()
      yesterdaysDate.setDate(yesterdaysDate.getDate() - 1)
      taskDate < yesterdaysDate

