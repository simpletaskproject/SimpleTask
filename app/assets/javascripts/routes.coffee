angular.module('SimpleTask').config ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise('/')

    $stateProvider

      .state 'index',
        url: '/'
        views:
          'menu':
            templateUrl: 'list/index.html'


      .state 'index.login',
        url: '^/login'
        views:
          'content@':
            templateUrl: 'user/_login.html'
            controller: 'UserCtrl',
#        onEnter: ($state, Auth) ->
#          Auth.currentUser().then ->
#            $state.go 'index'

      .state 'index.register',
        url: '^/register'
        views:
          'content@':
            templateUrl: 'user/_register.html'
            controller: 'UserCtrl',
#        onEnter: ($state, Auth) ->
#          Auth.currentUser().then ->
#            $state.go 'index'

      .state 'index.list',
        url: '^/:list_slug'
        views:
          'content@':
            templateUrl: 'list/show.html'

