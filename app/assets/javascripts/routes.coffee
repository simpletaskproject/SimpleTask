angular.module('SimpleTask').config ($stateProvider, $urlRouterProvider, $httpProvider) ->
    $urlRouterProvider.otherwise('/')

    $stateProvider

      .state 'index',
        url: '/'
        views:
          'menu':
            templateUrl: 'list/index.html'
            controller: 'ListsCtrl'


      .state 'index.login',
        url: '^/login'
        views:
          'content@':
            templateUrl: 'user/_login.html'
            controller: 'UserCtrl'
        onEnter: ($state, Auth) ->
          Auth.currentUser().then ->
            $state.go 'index'

      .state 'index.register',
        url: '^/register'
        views:
          'content@':
            templateUrl: 'user/_register.html'
            controller: 'UserCtrl'
        onEnter: ($state, Auth) ->
          Auth.currentUser().then ->
            $state.go 'index'

      .state 'index.list',
        url: '^/:list_slug'
        views:
          'content@':
            templateUrl: 'list/show.html'
            controller: 'TasksCtrl'


    $httpProvider.interceptors.push ($q, $injector) ->
      {
        'response': (response) ->
          return response
        'responseError': (rejection) ->
          if rejection.status == 401
            $injector.get('$state').go 'index.login'
          return $q.reject(rejection)
      }
