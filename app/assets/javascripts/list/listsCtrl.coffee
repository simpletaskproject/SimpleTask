angular.module('SimpleTask').controller 'ListsCtrl', ($scope, $http, List, Auth, $stateParams, $state, $urlRouter) ->
  $scope.newList = {}
  $scope.editedListID = null
  $scope.oldSlug = null
  $scope.oldTitle = null
  $scope.activeSlug = $state.params.list_slug
  $scope.signedIn = Auth.isAuthenticated


  List.index().success (response) ->
    $scope.lists = response

  $scope.create = (list) ->
    List.create($scope.newList).success (response) ->
      $scope.lists.push response
      $scope.newList = {}

  $scope.edit = (list) ->
    $scope.editedListID = list.id
    $scope.oldSlug = list.slug
    $scope.oldTitle = list.title

  $scope.cancelEdit = (list) ->
    list.title = $scope.oldTitle
    $scope.editedListID = null
    $scope.oldSlug = null
    $scope.oldTitle = null

  $scope.update = (list) ->
    List.update(list, $scope.oldSlug).success (response) ->
      list.slug = response.slug
      index = $scope.lists.indexOf(list)
      $scope.lists.splice(index, 1, list)
      $scope.editedListID = null
      $scope.oldSlug = null
      $state.go('index.list', { list_slug: list.slug })

  $scope.destroy = (list) ->
    List.destroy(list).success (response) ->
      index = $scope.lists.indexOf(list)
      $scope.lists.splice(index,1)
      if $scope.activeSlug == list.slug
        $state.go 'index'

  $scope.$on '$stateChangeSuccess', (e) ->
    $scope.activeSlug = $state.params.list_slug
    $scope.editedListID = null
    if $state.current.name == 'index'
      $scope.editedListID = null

