angular.module('SimpleTask').controller 'ListsCtrl', ($scope, $http, List, Auth, $stateParams, $state, $urlRouter) ->
  $scope.editedListID = null
  oldSlug = null
  oldTitle = null
  $scope.activeSlug = $state.params.list_slug
  $scope.signedIn = Auth.isAuthenticated
  $scope.lists = []
  $scope.newList = false


  List.index().success (lists) ->
    $scope.lists = lists

  $scope.create = (list) ->
    List.create(list).success (newList) ->
      $scope.lists.push newList
      $scope.newList = false;

  $scope.edit = (list) ->
    $scope.editedListID = list.id
    oldSlug = list.slug
    oldTitle = list.title

  $scope.cancelEdit = (list) ->
    list.title = oldTitle
    $scope.editedListID = null
    oldSlug = null
    oldTitle = null

  $scope.update = (list) ->
    List.update(list, oldSlug).success (updatedList) ->
      index = $scope.lists.indexOf(list)
      $scope.lists.splice(index, 1, updatedList)
      $scope.editedListID = null
      oldSlug = null
      $state.go('index.list', { list_slug: updatedList.slug })

  $scope.destroy = (list) ->
    List.destroy(list).success ->
      index = $scope.lists.indexOf(list)
      $scope.lists.splice(index,1)
      if $scope.activeSlug == list.slug
        $state.go 'index'

  $scope.$on '$stateChangeSuccess', (e) ->
    $scope.newList = false
    $scope.activeSlug = $state.params.list_slug
    $scope.editedListID = null
    if $state.current.name == 'index'
      $scope.editedListID = null

