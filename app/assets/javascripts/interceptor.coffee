#angular.module('SimpleTask').config ($stateProvider, $httpProvider) ->
#  $httpProvider.responseInterceptors.push ($q, $state) ->
#    success = (response) ->
#      return response
#
#    error = (response) ->
#      if response.status == 401
#        $state.go 'index.login'
#      return $q.reject response
#
#    return (promise) ->
#      return promise.then(success, error)
