angular.module('SimpleTask').controller 'AuthCtrl', ($scope, $state, Auth) ->

  $scope.signedIn = Auth.isAuthenticated
  $scope.logout = Auth.logout

  Auth.currentUser().then (user) ->
    $scope.user = user

  $scope.$on 'devise:new-registration', (e, user) ->
    $scope.user = user
  $scope.$on 'devise:login', (e, user) ->
    $scope.user = user
  $scope.$on 'devise:logout', (e, user) ->
    $scope.user = {}
    $state.go 'index', {}, {reload: true}
