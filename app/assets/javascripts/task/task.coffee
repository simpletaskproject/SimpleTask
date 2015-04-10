angular.module('SimpleTask').service 'Task', ($http, $stateParams) ->
  base = "/api/lists"

  index: (scope) ->
    $http.get("api/tasks")
  create: (task) ->
    $http.post("#{base}/#{$stateParams.list_slug}/tasks", task: task)
  update: (task) ->
    $http.put("#{base}/#{task.list.slug}/tasks/#{task.id}", task: task)
  destroy: (task) ->
    $http.delete("#{base}/#{task.list.slug}/tasks/#{task.id}")
  complete: (task) ->
    $http.put("#{base}/#{task.list.slug}/tasks/#{task.id}/complete")
