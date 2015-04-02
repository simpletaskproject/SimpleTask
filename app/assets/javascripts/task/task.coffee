angular.module('SimpleTask').service 'Task', ($http, $stateParams) ->
  base = "/api/lists/#{ $stateParams.list_slug }/tasks"

  create: (task) ->
    $http.post(base, task: task)
  update: (task) ->
    $http.put("#{base}/#{task.id}", task: task)
  destroy: (task) ->
    $http.delete("#{base}/#{task.id}")

