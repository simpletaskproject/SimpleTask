angular.module('SimpleTask').config ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise('/')

    $stateProvider

      .state 'index',
        url: '/'
        templateUrl: 'list/index.html'


      .state 'index.login',
        url: '^/login'
        templateUrl: 'user/_login.html'
        controller: 'UserCtrl',
        onEnter: ($state, Auth) ->
          Auth.currentUser().then ->
            $state.go 'index'

      .state 'index.register',
        url: '^/register'
        templateUrl: 'user/_register.html'
        controller: 'UserCtrl',
        onEnter: ($state, Auth) ->
          Auth.currentUser().then ->
            $state.go 'index'

      .state 'index.list',
        url: '^/:list_slug'
        templateUrl: 'list/show.html'

