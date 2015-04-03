angular.module('SimpleTask').service 'List', ($http) ->
  base = '/api/lists'
  index: ->
    $http.get(base)
  show: (name) ->
    $http.get("#{base}/#{name}")
  create: (list) ->
    $http.post(base, list: list)
  update: (list, oldSlug) ->
    $http.put("#{base}/#{oldSlug}", list: list)
  destroy: (list) ->
    $http.delete("#{base}/#{list.slug}")
