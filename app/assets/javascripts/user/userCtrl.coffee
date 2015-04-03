angular.module('SimpleTask').controller 'UserCtrl', ($scope, $state, Auth) ->

  $scope.login = ->
    Auth.login($scope.user).then ->
      $state.go 'index', {}, {reload: true}

  $scope.register = ->
    Auth.register($scope.user).then ->
      $state.go 'index'
