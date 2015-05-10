angular.module('SimpleTask').controller 'UserCtrl', ($scope, $window, $state, Auth) ->

  $scope.login = ->
    Auth.login($scope.user)
    .then ->
      ($state.go 'index', {}, {reload: true})
    .catch ->
      $scope.error = "There is no such account, try again"

  $scope.loginGithub = ->
    $window.location.href = "http://simpletask.herokuapp.com/users/auth/github"

  $scope.register = ->
    Auth.register($scope.user).then ->
      $state.go 'index'
    .catch ->
      $scope.error = "The email adress is being used"
