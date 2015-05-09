angular.module('SimpleTask').controller 'UserCtrl', ($scope, $window, $state, Auth) ->

  $scope.login = ->
    Auth.login($scope.user)
    .then ->
      ($state.go 'index', {}, {reload: true})
    .catch ->
      $scope.error = "ERROR"
      console.log $scope.error

  $scope.loginGithub = ->
    $window.location.href = "http://localhost:3000/users/auth/github"
    #$state.go 'index', {}, {reload: true}

  $scope.register = ->
    Auth.register($scope.user).then ->
      $state.go 'index'
