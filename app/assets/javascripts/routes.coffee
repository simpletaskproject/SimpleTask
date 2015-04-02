angular.module('SimpleTask').config ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise('/')

    $stateProvider

      .state 'index',
        url: '/'
        controller: 'ListCtrl',
        resolve:
          lists: (List) ->
            List.index()
        templateUrl: 'list/index.html'


      .state 'login',
        url: '/login'
        templateUrl: 'user/_login.html'
        controller: 'UserCtrl',
        onEnter: ($state, Auth) ->
          Auth.currentUser().then ->
            $state.go 'index'

      .state 'register',
        url: '/register'
        templateUrl: 'user/_register.html'
        controller: 'UserCtrl',
        onEnter: ($state, Auth) ->
          Auth.currentUser().then ->
            $state.go 'index'

      .state 'list',
        url: '/:list_slug'
        controller: 'ListCtrl'
        templateUrl: 'list/show.html'

